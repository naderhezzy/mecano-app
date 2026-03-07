-- ============================================================================
-- Mecano App - Initial Database Schema Migration
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. Extensions
-- ----------------------------------------------------------------------------
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ----------------------------------------------------------------------------
-- 2. Enums
-- ----------------------------------------------------------------------------
CREATE TYPE fuel_type AS ENUM (
  'gasoline',
  'diesel',
  'electric',
  'hybrid',
  'lpg'
);

CREATE TYPE service_type AS ENUM (
  'oil_change',
  'brakes',
  'tires',
  'engine',
  'transmission',
  'electrical',
  'ac',
  'body',
  'inspection',
  'battery',
  'suspension',
  'exhaust',
  'other'
);

CREATE TYPE booking_status AS ENUM (
  'pending',
  'confirmed',
  'in_progress',
  'completed',
  'cancelled'
);

CREATE TYPE document_type AS ENUM (
  'insurance',
  'registration',
  'technical_inspection',
  'other'
);

-- ----------------------------------------------------------------------------
-- 3. Tables
-- ----------------------------------------------------------------------------

-- user_profiles
CREATE TABLE user_profiles (
  id             UUID PRIMARY KEY REFERENCES auth.users (id) ON DELETE CASCADE,
  full_name      TEXT,
  phone          TEXT,
  location       TEXT,
  preferred_language TEXT NOT NULL DEFAULT 'en',
  avatar_url     TEXT,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- vehicles
CREATE TABLE vehicles (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id      UUID NOT NULL REFERENCES auth.users (id) ON DELETE CASCADE,
  make         TEXT NOT NULL,
  model        TEXT NOT NULL,
  year         INT,
  mileage      INT,
  vin          TEXT,
  fuel_type    fuel_type,
  plate_number TEXT,
  color        TEXT,
  photo_urls   TEXT[] DEFAULT '{}',
  notes        TEXT,
  is_primary   BOOLEAN DEFAULT FALSE,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- service_categories
CREATE TABLE service_categories (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name_en      TEXT NOT NULL,
  name_fr      TEXT NOT NULL,
  icon_name    TEXT NOT NULL,
  service_type service_type NOT NULL,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- garages
CREATE TABLE garages (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name            TEXT NOT NULL,
  address         TEXT NOT NULL,
  city            TEXT NOT NULL,
  lat             FLOAT8,
  lng             FLOAT8,
  phone           TEXT,
  photo_urls      TEXT[] DEFAULT '{}',
  average_rating  FLOAT DEFAULT 0,
  total_reviews   INT DEFAULT 0,
  is_verified     BOOLEAN DEFAULT FALSE,
  working_hours   JSONB DEFAULT '{}',
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- garage_services
CREATE TABLE garage_services (
  id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  garage_id           UUID NOT NULL REFERENCES garages (id) ON DELETE CASCADE,
  service_category_id UUID NOT NULL REFERENCES service_categories (id) ON DELETE CASCADE,
  price_min           NUMERIC,
  price_max           NUMERIC,
  estimated_duration  INT
);

-- garage_reviews
CREATE TABLE garage_reviews (
  id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  garage_id  UUID NOT NULL REFERENCES garages (id) ON DELETE CASCADE,
  user_id    UUID NOT NULL REFERENCES auth.users (id) ON DELETE CASCADE,
  rating     INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment    TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (garage_id, user_id)
);

-- maintenance_records
CREATE TABLE maintenance_records (
  id                    UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  vehicle_id            UUID NOT NULL REFERENCES vehicles (id) ON DELETE CASCADE,
  service_type          service_type NOT NULL,
  title                 TEXT NOT NULL,
  mileage_at_service    INT,
  cost                  NUMERIC,
  service_date          DATE NOT NULL,
  garage_id             UUID REFERENCES garages (id) ON DELETE SET NULL,
  next_service_date     DATE,
  next_service_mileage  INT,
  notes                 TEXT,
  photo_urls            TEXT[] DEFAULT '{}',
  created_at            TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at            TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- bookings
CREATE TABLE bookings (
  id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id             UUID NOT NULL REFERENCES auth.users (id) ON DELETE CASCADE,
  garage_id           UUID NOT NULL REFERENCES garages (id) ON DELETE CASCADE,
  vehicle_id          UUID NOT NULL REFERENCES vehicles (id) ON DELETE CASCADE,
  service_category_id UUID REFERENCES service_categories (id) ON DELETE SET NULL,
  status              booking_status NOT NULL DEFAULT 'pending',
  appointment_date    DATE NOT NULL,
  appointment_time    TIME NOT NULL,
  notes               TEXT,
  estimated_cost      NUMERIC,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- vehicle_documents
CREATE TABLE vehicle_documents (
  id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  vehicle_id    UUID NOT NULL REFERENCES vehicles (id) ON DELETE CASCADE,
  document_type document_type NOT NULL,
  title         TEXT NOT NULL,
  file_url      TEXT NOT NULL,
  expiry_date   DATE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ----------------------------------------------------------------------------
-- 4. Indexes
-- ----------------------------------------------------------------------------
CREATE INDEX idx_vehicles_user_id ON vehicles (user_id);
CREATE INDEX idx_garage_services_garage_id ON garage_services (garage_id);
CREATE INDEX idx_garage_services_category_id ON garage_services (service_category_id);
CREATE INDEX idx_garage_reviews_garage_id ON garage_reviews (garage_id);
CREATE INDEX idx_garage_reviews_user_id ON garage_reviews (user_id);
CREATE INDEX idx_maintenance_records_vehicle_id ON maintenance_records (vehicle_id);
CREATE INDEX idx_bookings_user_id ON bookings (user_id);
CREATE INDEX idx_bookings_garage_id ON bookings (garage_id);
CREATE INDEX idx_bookings_vehicle_id ON bookings (vehicle_id);
CREATE INDEX idx_vehicle_documents_vehicle_id ON vehicle_documents (vehicle_id);

-- ----------------------------------------------------------------------------
-- 5. Functions & Triggers
-- ----------------------------------------------------------------------------

-- 5a. Auto-create user_profiles on auth.users insert -------------------------
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.user_profiles (id, full_name, avatar_url)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data ->> 'full_name', ''),
    COALESCE(NEW.raw_user_meta_data ->> 'avatar_url', '')
  );
  RETURN NEW;
END;
$$;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

-- 5b. Generic updated_at trigger --------------------------------------------
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

CREATE TRIGGER set_updated_at BEFORE UPDATE ON user_profiles
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON vehicles
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON garages
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON garage_reviews
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON maintenance_records
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON bookings
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON vehicle_documents
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- 5c. Auto-recalculate garage average_rating & total_reviews -----------------
CREATE OR REPLACE FUNCTION public.update_garage_rating()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  target_garage_id UUID;
BEGIN
  -- Determine which garage was affected
  IF TG_OP = 'DELETE' THEN
    target_garage_id := OLD.garage_id;
  ELSE
    target_garage_id := NEW.garage_id;
  END IF;

  UPDATE garages
  SET
    average_rating = COALESCE(
      (SELECT AVG(rating)::FLOAT FROM garage_reviews WHERE garage_id = target_garage_id),
      0
    ),
    total_reviews = (
      SELECT COUNT(*) FROM garage_reviews WHERE garage_id = target_garage_id
    ),
    updated_at = now()
  WHERE id = target_garage_id;

  IF TG_OP = 'DELETE' THEN
    RETURN OLD;
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER on_garage_review_change
  AFTER INSERT OR UPDATE OR DELETE ON garage_reviews
  FOR EACH ROW
  EXECUTE FUNCTION public.update_garage_rating();

-- ----------------------------------------------------------------------------
-- 6. Row Level Security
-- ----------------------------------------------------------------------------

-- Enable RLS on all tables
ALTER TABLE user_profiles       ENABLE ROW LEVEL SECURITY;
ALTER TABLE vehicles            ENABLE ROW LEVEL SECURITY;
ALTER TABLE service_categories  ENABLE ROW LEVEL SECURITY;
ALTER TABLE garages             ENABLE ROW LEVEL SECURITY;
ALTER TABLE garage_services     ENABLE ROW LEVEL SECURITY;
ALTER TABLE garage_reviews      ENABLE ROW LEVEL SECURITY;
ALTER TABLE maintenance_records ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings            ENABLE ROW LEVEL SECURITY;
ALTER TABLE vehicle_documents   ENABLE ROW LEVEL SECURITY;

-- user_profiles: owner CRUD --------------------------------------------------
CREATE POLICY "Users can view their own profile"
  ON user_profiles FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Users can insert their own profile"
  ON user_profiles FOR INSERT
  WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can update their own profile"
  ON user_profiles FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can delete their own profile"
  ON user_profiles FOR DELETE
  USING (auth.uid() = id);

-- vehicles: owner CRUD -------------------------------------------------------
CREATE POLICY "Users can view their own vehicles"
  ON vehicles FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own vehicles"
  ON vehicles FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own vehicles"
  ON vehicles FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own vehicles"
  ON vehicles FOR DELETE
  USING (auth.uid() = user_id);

-- maintenance_records: owner CRUD (through vehicle ownership) -----------------
CREATE POLICY "Users can view their own maintenance records"
  ON maintenance_records FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM vehicles
      WHERE vehicles.id = maintenance_records.vehicle_id
        AND vehicles.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can insert maintenance records for their vehicles"
  ON maintenance_records FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM vehicles
      WHERE vehicles.id = maintenance_records.vehicle_id
        AND vehicles.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can update their own maintenance records"
  ON maintenance_records FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM vehicles
      WHERE vehicles.id = maintenance_records.vehicle_id
        AND vehicles.user_id = auth.uid()
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM vehicles
      WHERE vehicles.id = maintenance_records.vehicle_id
        AND vehicles.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can delete their own maintenance records"
  ON maintenance_records FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM vehicles
      WHERE vehicles.id = maintenance_records.vehicle_id
        AND vehicles.user_id = auth.uid()
    )
  );

-- bookings: owner CRUD -------------------------------------------------------
CREATE POLICY "Users can view their own bookings"
  ON bookings FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own bookings"
  ON bookings FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own bookings"
  ON bookings FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own bookings"
  ON bookings FOR DELETE
  USING (auth.uid() = user_id);

-- vehicle_documents: owner CRUD (through vehicle ownership) -------------------
CREATE POLICY "Users can view their own vehicle documents"
  ON vehicle_documents FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM vehicles
      WHERE vehicles.id = vehicle_documents.vehicle_id
        AND vehicles.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can insert documents for their vehicles"
  ON vehicle_documents FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM vehicles
      WHERE vehicles.id = vehicle_documents.vehicle_id
        AND vehicles.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can update their own vehicle documents"
  ON vehicle_documents FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM vehicles
      WHERE vehicles.id = vehicle_documents.vehicle_id
        AND vehicles.user_id = auth.uid()
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM vehicles
      WHERE vehicles.id = vehicle_documents.vehicle_id
        AND vehicles.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can delete their own vehicle documents"
  ON vehicle_documents FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM vehicles
      WHERE vehicles.id = vehicle_documents.vehicle_id
        AND vehicles.user_id = auth.uid()
    )
  );

-- garages: public SELECT ------------------------------------------------------
CREATE POLICY "Garages are viewable by everyone"
  ON garages FOR SELECT
  USING (true);

-- garage_reviews: public SELECT, authenticated INSERT/UPDATE/DELETE own -------
CREATE POLICY "Garage reviews are viewable by everyone"
  ON garage_reviews FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can insert reviews"
  ON garage_reviews FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own reviews"
  ON garage_reviews FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own reviews"
  ON garage_reviews FOR DELETE
  USING (auth.uid() = user_id);

-- service_categories: public SELECT -------------------------------------------
CREATE POLICY "Service categories are viewable by everyone"
  ON service_categories FOR SELECT
  USING (true);

-- garage_services: public SELECT ----------------------------------------------
CREATE POLICY "Garage services are viewable by everyone"
  ON garage_services FOR SELECT
  USING (true);

-- ----------------------------------------------------------------------------
-- 7. Seed Data
-- ----------------------------------------------------------------------------

-- 7a. Service Categories (13 entries) ----------------------------------------
INSERT INTO service_categories (name_en, name_fr, icon_name, service_type) VALUES
  ('Oil Change',            'Vidange',                    'oil_barrel',          'oil_change'),
  ('Brakes',                'Freins',                     'brake_alert',         'brakes'),
  ('Tires',                 'Pneus',                      'tire_repair',         'tires'),
  ('Engine Repair',         'Reparation Moteur',          'engineering',         'engine'),
  ('Transmission',          'Transmission',               'settings',            'transmission'),
  ('Electrical System',     'Systeme Electrique',         'electrical_services', 'electrical'),
  ('Air Conditioning',      'Climatisation',              'ac_unit',             'ac'),
  ('Body Work',             'Carrosserie',                'directions_car',      'body'),
  ('Technical Inspection',  'Controle Technique',         'checklist',           'inspection'),
  ('Battery',               'Batterie',                   'battery_charging_full', 'battery'),
  ('Suspension',            'Suspension',                 'swap_vert',           'suspension'),
  ('Exhaust System',        'Systeme Echappement',        'air',                 'exhaust'),
  ('Other Services',        'Autres Services',            'build',               'other');

-- 7b. Sample Garages in Tunisia (5 entries) -----------------------------------
INSERT INTO garages (name, address, city, lat, lng, phone, is_verified, working_hours) VALUES
  (
    'Garage Ben Ali Auto',
    '23 Rue de Marseille, Centre Ville',
    'Tunis',
    36.8065,
    10.1815,
    '+216 71 234 567',
    TRUE,
    '{"monday":    {"open": "08:00", "close": "18:00"},
      "tuesday":   {"open": "08:00", "close": "18:00"},
      "wednesday": {"open": "08:00", "close": "18:00"},
      "thursday":  {"open": "08:00", "close": "18:00"},
      "friday":    {"open": "08:00", "close": "18:00"},
      "saturday":  {"open": "08:00", "close": "13:00"},
      "sunday":    "closed"}'::jsonb
  ),
  (
    'Mecanique Rapide Sfax',
    '45 Avenue Habib Bourguiba',
    'Sfax',
    34.7406,
    10.7603,
    '+216 74 456 789',
    TRUE,
    '{"monday":    {"open": "07:30", "close": "17:30"},
      "tuesday":   {"open": "07:30", "close": "17:30"},
      "wednesday": {"open": "07:30", "close": "17:30"},
      "thursday":  {"open": "07:30", "close": "17:30"},
      "friday":    {"open": "07:30", "close": "17:30"},
      "saturday":  {"open": "08:00", "close": "12:30"},
      "sunday":    "closed"}'::jsonb
  ),
  (
    'AutoFix Sousse',
    '12 Rue Ibn Khaldoun, Sahloul',
    'Sousse',
    35.8288,
    10.6405,
    '+216 73 345 678',
    TRUE,
    '{"monday":    {"open": "08:00", "close": "18:30"},
      "tuesday":   {"open": "08:00", "close": "18:30"},
      "wednesday": {"open": "08:00", "close": "18:30"},
      "thursday":  {"open": "08:00", "close": "18:30"},
      "friday":    {"open": "08:00", "close": "18:30"},
      "saturday":  {"open": "08:00", "close": "14:00"},
      "sunday":    "closed"}'::jsonb
  ),
  (
    'Garage El Amen',
    '78 Avenue de la Liberte, La Marsa',
    'Tunis',
    36.8783,
    10.3253,
    '+216 71 987 654',
    FALSE,
    '{"monday":    {"open": "08:30", "close": "17:00"},
      "tuesday":   {"open": "08:30", "close": "17:00"},
      "wednesday": {"open": "08:30", "close": "17:00"},
      "thursday":  {"open": "08:30", "close": "17:00"},
      "friday":    {"open": "08:30", "close": "17:00"},
      "saturday":  {"open": "09:00", "close": "13:00"},
      "sunday":    "closed"}'::jsonb
  ),
  (
    'Centre Auto Sfax Sud',
    '156 Route de Gabes, Sfax Sud',
    'Sfax',
    34.7200,
    10.7500,
    '+216 74 654 321',
    TRUE,
    '{"monday":    {"open": "07:00", "close": "19:00"},
      "tuesday":   {"open": "07:00", "close": "19:00"},
      "wednesday": {"open": "07:00", "close": "19:00"},
      "thursday":  {"open": "07:00", "close": "19:00"},
      "friday":    {"open": "07:00", "close": "19:00"},
      "saturday":  {"open": "07:00", "close": "14:00"},
      "sunday":    "closed"}'::jsonb
  );
