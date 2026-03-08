# Mecano — Database Architecture

## Choice: PostgreSQL (via Supabase)

### Why SQL over NoSQL

Mecano's data is **deeply relational** — 9 tables with 12+ foreign key relationships. A single booking references 4 entities simultaneously (user, garage, vehicle, service category). This is textbook relational data.

| Requirement | SQL (PostgreSQL) | NoSQL (Firestore/MongoDB) |
|---|---|---|
| Relational data (12+ FKs, JOINs) | Native | Denormalization required |
| Booking transactions (ACID) | Row-level locking | Eventual consistency |
| Aggregates (AVG rating, SUM cost) | Built-in SQL functions | Manual counter documents |
| Geolocation (nearby garages) | PostGIS extension | GeoHash workarounds |
| Data integrity (enums, FKs, RLS) | Database-enforced | Application-only validation |
| Scale needed (2.3M vehicles) | Trivial for PostgreSQL | Horizontal scaling overkill |

Every major fleet management system and booking platform uses relational databases.

### Why Supabase as the hosting layer

| Factor | Details |
|---|---|
| Managed PostgreSQL | No infra to maintain |
| Auth | Built-in email/password, social, phone |
| Row-Level Security | Data isolation enforced at DB level |
| Storage | S3-compatible with CDN for vehicle photos |
| Realtime | Postgres Changes for booking status updates |
| PostGIS | First-class geospatial extension |
| Cost | Free tier for dev, $25/month Pro for production |
| Region | Paris (eu-west-3) — ~30-50ms to Tunisia |
| Vendor lock-in | Low — standard PostgreSQL, portable |
| Flutter SDK | `supabase_flutter` — mature, 365K+ weekly downloads |

### Known limitations

| Limitation | Mitigation |
|---|---|
| No offline support | Drift (local SQLite) handles offline-first |
| No push notifications | Firebase Cloud Messaging added separately |
| Edge Functions are limited | Plan for custom API layer for complex logic |
| Free tier pauses after 7 days idle | Use Pro ($25/month) for production |
| Email rate limit (3/hour on free SMTP) | Set up custom SMTP (Resend) |
| No Africa/Middle East region | Paris region provides acceptable latency |

---

## Schema Overview

### Tables

| Table | Purpose | Key Relations |
|---|---|---|
| `user_profiles` | User info (auto-created on auth signup) | — |
| `vehicles` | User's cars | → user_profiles |
| `maintenance_records` | Service history per vehicle | → vehicles, → garages (optional) |
| `vehicle_documents` | Insurance, registration docs | → vehicles |
| `service_categories` | 13 predefined service types | — |
| `garages` | Service providers | — |
| `garage_services` | Services offered + pricing | → garages, → service_categories |
| `garage_reviews` | User reviews (1 per user per garage) | → garages, → user_profiles |
| `bookings` | Appointments | → user_profiles, → garages, → vehicles, → service_categories |

### Enums

| Enum | Values |
|---|---|
| `fuel_type` | essence, diesel, gpl, electric, hybrid |
| `service_type` | maintenance, repair, inspection, bodywork, other |
| `booking_status` | pending, confirmed, in_progress, completed, cancelled |
| `document_type` | insurance, registration, inspection_certificate, other |

### Triggers

- **Auto user_profiles**: Creates a profile row when a user signs up via Supabase Auth
- **Auto updated_at**: Updates `updated_at` timestamp on every row modification
- **Auto rating recalculation**: Recomputes `garages.average_rating` and `total_reviews` on review insert/update/delete

### Row-Level Security

All tables have RLS enabled:
- **User-owned data** (vehicles, maintenance, bookings, documents, profile): Owner-only CRUD via `auth.uid() = user_id`
- **Public data** (garages, services, categories): Public SELECT, authenticated INSERT for reviews
- **Reviews**: One review per user per garage enforced via unique constraint

### Seed Data

- 13 service categories (oil change, brakes, tires, engine, transmission, electrical, AC, body, inspection, battery, suspension, exhaust, other)
- 5 sample garages in Tunis, Sfax, Sousse

---

## Offline-First Architecture

```
┌─────────────┐     ┌──────────────────┐     ┌──────────────┐
│  Flutter UI  │────▶│   Repositories   │────▶│   Supabase   │
│  (Screens)   │     │  (Data Layer)    │     │  (Remote DB) │
└─────────────┘     │                  │     └──────────────┘
                    │  Read: local     │
                    │  Write: local    │     ┌──────────────┐
                    │  Sync: remote    │────▶│  Drift/SQLite │
                    └──────────────────┘     │  (Local DB)   │
                                            └──────────────┘
```

### Pattern

1. **Read**: Query Drift (local) first → background fetch from Supabase → update Drift → UI auto-updates via streams
2. **Write**: Write to Drift immediately (`isSynced: false`) → push to Supabase if online → mark `isSynced: true`
3. **Sync**: On connectivity restore, push all records where `isSynced = false`

### Local tables (Drift)

All Drift tables mirror remote schema and include:
- `isSynced` (bool) — tracks sync status
- Same columns as Supabase tables for 1:1 mapping

---

## Data Layer Architecture

### Current structure

```
lib/features/{feature}/
├── domain/
│   └── models/          # Freezed models (DB-agnostic)
├── data/
│   └── repositories/    # Concrete repos (Supabase + Drift)
└── presentation/
    ├── providers/       # Riverpod providers
    └── screens/         # UI (no DB knowledge)
```

### Migration-friendliness

**Clean layers** (no Supabase knowledge):
- Domain models (Freezed) — pure business objects with JSON serialization
- Presentation layer — only knows about domain models and providers
- Error types — generic `AppException` hierarchy

**Coupled layer** (Supabase-specific):
- Repositories — directly use `SupabaseClient`, catch `PostgrestException`
- To swap backends: rewrite repository implementations (~6 files)
- Domain models and UI remain untouched

### Future improvement path (if migration becomes likely)

Extract abstract repository interfaces into `domain/repositories/`:
```dart
// domain/repositories/vehicle_repository.dart
abstract class VehicleRepositoryBase {
  FutureEither<List<Vehicle>> getVehicles(String userId);
  FutureEither<Vehicle> addVehicle(Vehicle vehicle);
  // ...
}

// data/repositories/supabase_vehicle_repository.dart
class SupabaseVehicleRepository implements VehicleRepositoryBase { ... }
```

This is intentionally deferred — unnecessary abstraction for a single-backend MVP.

---

## Setup

### 1. Create Supabase project

Go to [supabase.com](https://supabase.com) → New Project

### 2. Run migration

In Supabase SQL Editor, run:
```
supabase/migrations/00001_initial_schema.sql
```

This creates all tables, enums, triggers, RLS policies, and seed data.

### 3. Configure environment

Run the app with:
```bash
flutter run \
  --dart-define=SUPABASE_URL=https://yourproject.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your_anon_key
```

### 4. Optional: Custom SMTP for auth emails

Supabase free SMTP is limited to 3 emails/hour. Configure a custom SMTP provider:
- Supabase Dashboard → Settings → Auth → SMTP Settings
- Recommended: [Resend](https://resend.com) (free for 100 emails/day)

### 5. Optional: Enable PostGIS for geolocation

```sql
CREATE EXTENSION IF NOT EXISTS postgis;
ALTER TABLE garages ADD COLUMN geom geometry(Point, 4326);
UPDATE garages SET geom = ST_SetSRID(ST_MakePoint(lng, lat), 4326);
CREATE INDEX idx_garages_geom ON garages USING GIST (geom);
```

---

## File References

| File | Purpose |
|---|---|
| `supabase/migrations/00001_initial_schema.sql` | Full schema + seed data |
| `lib/database/app_database.dart` | Drift database definition |
| `lib/database/tables/*.dart` | Drift table definitions |
| `lib/shared/providers/supabase_provider.dart` | Supabase client providers |
| `lib/shared/providers/database_provider.dart` | Drift database provider |
| `lib/core/env/env.dart` | Environment variables (URL, key) |
