# Mecano App - Project Progress

## Overview
Virtual Mechanic mobile app for Tunisia targeting 2.3M vehicles. Starting with **Path D (Manual + GPS)** — user input only, no hardware required.

**Tech Stack**: Flutter + Riverpod + GoRouter + Supabase + Drift + Freezed + fpdart

---

## Current Status: 🟡 In Progress — Phase 0-4 (Foundation + Core Features)

| Phase | Description | Status |
|-------|-------------|--------|
| Phase 0 | Project Setup | ✅ Complete |
| Phase 1 | Supabase Schema | 🔄 In Progress |
| Phase 2 | Auth + Splash + Onboarding + Routing | 🔄 In Progress |
| Phase 3 | User Profile | 🔄 In Progress |
| Phase 4 | Vehicle Management (My Garage) | ⏳ Pending |
| Phase 5 | Maintenance Records | ⏳ Pending |
| Phase 6 | Garages & Service Providers | ⏳ Pending |
| Phase 7 | Booking System | ⏳ Pending |
| Phase 8 | Home Dashboard | ⏳ Pending |
| Phase 9 | Localization + Polish | ⏳ Pending |

---

## Phase 0: Project Setup ✅

### Completed
- [x] Flutter project created (`flutter create --org com.mecano`)
- [x] `pubspec.yaml` configured with all dependencies (35+ packages)
- [x] Folder structure created (feature-first + clean architecture)
- [x] `analysis_options.yaml` with very_good_analysis
- [x] `build.yaml` for Drift and json_serializable config
- [x] `l10n.yaml` for localization setup
- [x] Core modules:
  - `lib/core/env/env.dart` — environment variables (SUPABASE_URL, SUPABASE_ANON_KEY)
  - `lib/core/errors/app_exception.dart` — sealed exception hierarchy
  - `lib/core/typedefs/typedefs.dart` — FutureEither, FutureVoid, JsonMap
  - `lib/core/constants/app_constants.dart` — Tunisia-specific constants (governorates, car makes/models)
  - `lib/core/extensions/context_extensions.dart` — BuildContext helpers
  - `lib/core/utils/validators.dart` — email, phone, plate number, VIN validation
  - `lib/core/utils/currency_formatter.dart` — TND formatting (3 decimals)
- [x] Theme system:
  - `lib/theme/app_colors.dart` — primary blue, secondary amber, semantic colors
  - `lib/theme/app_spacing.dart` — spacing constants and SizedBox helpers
  - `lib/theme/app_theme.dart` — Material 3 theme with custom components
- [x] Shared providers:
  - `lib/shared/providers/supabase_provider.dart` — Supabase client + auth providers
  - `lib/shared/providers/connectivity_provider.dart` — connectivity stream
  - `lib/shared/providers/database_provider.dart` — Drift AppDatabase provider
- [x] Shared widgets:
  - `lib/shared/widgets/app_loading.dart`
  - `lib/shared/widgets/app_error.dart`
  - `lib/shared/widgets/empty_state.dart`
- [x] Database tables (Drift):
  - UserProfilesTable, VehiclesTable, MaintenanceRecordsTable
  - GaragesTable, GarageServicesTable, ServiceCategoriesTable, BookingsTable
- [x] `lib/database/app_database.dart` — DriftDatabase definition
- [x] App entry points: `main.dart`, `bootstrap.dart`, `app.dart`
- [x] Routing: `lib/routing/app_router.dart` with GoRouter + auth guards
- [x] Navigation: `lib/routing/scaffold_with_nav_bar.dart` — 5-tab bottom nav
- [x] Localization: `app_en.arb` + `app_fr.arb` with 100+ strings
- [x] Dependencies installed (`flutter pub get`)

### Folder Structure
```
lib/
├── main.dart / bootstrap.dart / app.dart
├── core/           # constants, env, errors, extensions, utils, typedefs
├── database/       # Drift DB definition + tables/
├── l10n/           # app_en.arb, app_fr.arb
├── routing/        # GoRouter config + scaffold_with_nav_bar
├── theme/          # colors, spacing, theme
├── shared/         # providers, widgets
└── features/
    ├── splash/
    ├── onboarding/
    ├── auth/
    ├── profile/
    ├── vehicles/
    ├── maintenance/
    ├── garages/
    ├── bookings/
    └── home/
```

---

## Phase 1: Supabase Schema 🔄

### In Progress
- [ ] `supabase/migrations/00001_initial_schema.sql`
- Tables: user_profiles, vehicles, service_categories, garages, garage_services, garage_reviews, maintenance_records, bookings, vehicle_documents
- Enums: fuel_type, service_type, booking_status, document_type
- Triggers: auto user_profiles, auto updated_at, auto rating recalculation
- RLS policies for all tables
- Seed data: 13 service categories, 5 sample garages

---

## Phase 2: Auth + Splash + Onboarding 🔄

### In Progress
- [ ] `lib/features/auth/domain/models/app_user.dart` — Freezed model
- [ ] `lib/features/auth/data/repositories/auth_repository.dart` — Supabase auth
- [ ] `lib/features/auth/presentation/providers/auth_providers.dart` — Riverpod providers
- [ ] `lib/features/auth/presentation/screens/login_screen.dart`
- [ ] `lib/features/auth/presentation/screens/register_screen.dart`
- [ ] `lib/features/auth/presentation/screens/forgot_password_screen.dart`
- [ ] `lib/features/splash/presentation/screens/splash_screen.dart`
- [ ] `lib/features/onboarding/presentation/screens/onboarding_screen.dart`

---

## Phase 3: User Profile 🔄

### In Progress
- [ ] `lib/features/profile/domain/models/user_profile.dart` — Freezed model
- [ ] `lib/features/profile/data/repositories/profile_repository.dart` — offline-first
- [ ] `lib/features/profile/presentation/screens/profile_screen.dart`
- [ ] `lib/features/profile/presentation/screens/edit_profile_screen.dart`

---

## Phase 4: Vehicle Management ⏳

### Planned
- Vehicle model (Freezed) + fuel_type enum
- Vehicle repository (offline-first reference implementation)
- GarageScreen — vehicle list with FAB
- AddVehicleScreen — form with photo picker, Tunisia-specific make/model
- EditVehicleScreen
- VehicleDetailScreen — Car View Page with hero photo, stats, timeline

---

## Phase 5: Maintenance Records ⏳

### Planned
- MaintenanceRecord model (Freezed)
- Maintenance repository
- AddMaintenanceScreen
- Maintenance timeline widget on VehicleDetailScreen
- Service type selector with 13 categories

---

## Phase 6: Garages & Service Providers ⏳

### Planned
- Garage model + GarageReview model (Freezed)
- Garage repository
- GaragesListScreen — search + filter by city/service
- GarageDetailScreen — photos, services, hours, map, reviews, "Book Now"

---

## Phase 7: Booking System ⏳

### Planned
- Booking model + BookingStatus enum (Freezed)
- Booking repository
- BookingFlowScreen — 4-step wizard (service → vehicle → date/time → review)
- BookingConfirmationScreen
- BookingHistoryScreen
- BookingDetailScreen
- BookingFlowNotifier (Riverpod class-based)

---

## Phase 8: Home Dashboard ⏳

### Planned
- HomeScreen layout:
  - Greeting header
  - Primary vehicle summary card
  - Upcoming maintenance reminders
  - Recent/upcoming bookings
  - Quick action row (Add Vehicle, Log Service, Find Garage, View Bookings)

---

## Phase 9: Localization + Polish ⏳

### Planned
- Complete l10n string extraction (all hardcoded → ARB keys)
- Background sync service on connectivity restore
- Pull-to-refresh on all list screens
- Loading skeletons (shimmer)
- Error boundaries with retry
- Tunisia-specific: TND currency, +216 phone, governorate dropdowns

---

## Navigation Map (20 screens)

```
/                               → SplashScreen
/onboarding                     → OnboardingScreen
/auth/login                     → LoginScreen
/auth/register                  → RegisterScreen
/auth/forgot-password           → ForgotPasswordScreen

Bottom Nav Shell:
  /home                         → HomeScreen
  /garage                       → GarageScreen (vehicle list)
  /garage/add                   → AddVehicleScreen
  /garage/:vehicleId            → VehicleDetailScreen
  /garage/:vehicleId/edit       → EditVehicleScreen
  /garage/:vehicleId/maintenance/add → AddMaintenanceScreen
  /services                     → GaragesListScreen
  /services/:garageId           → GarageDetailScreen
  /services/:garageId/book      → BookingFlowScreen
  /bookings                     → BookingHistoryScreen
  /bookings/:bookingId          → BookingDetailScreen
  /profile                      → ProfileScreen
  /profile/edit                 → EditProfileScreen
```

---

## Key Dependencies

| Package | Purpose |
|---------|---------|
| flutter_riverpod / riverpod_annotation | State management |
| go_router | Declarative routing |
| supabase_flutter | Backend (auth, DB, storage) |
| drift + sqlite3_flutter_libs | Local SQLite (offline-first) |
| freezed_annotation + freezed | Immutable models |
| fpdart | Either pattern for error handling |
| connectivity_plus | Network detection |
| cached_network_image | Image caching |
| flutter_map + latlong2 + geolocator | Maps & location |
| table_calendar | Date picker for bookings |
| shimmer | Loading skeletons |

---

## Verification Checklist

- [ ] `flutter pub get` — no errors
- [ ] `dart run build_runner build` — code gen completes
- [ ] Auth flow: Register → login → home
- [ ] Vehicle CRUD: Add → list → detail → edit → delete
- [ ] Maintenance: Log → timeline on vehicle detail
- [ ] Garages: Browse → filter → detail → reviews
- [ ] Booking: 4-step flow → confirmation → history
- [ ] Offline: Add vehicle offline → sync when online
- [ ] Localization: English + French switching
