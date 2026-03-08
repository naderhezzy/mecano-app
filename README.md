# Mecano

Virtual Mechanic mobile app for Tunisia, targeting 2.3M+ vehicles. Starting with **manual input** (Path D) — no hardware required.

## Features

- **My Garage** — Add and manage multiple vehicles with Tunisia-specific makes/models
- **Maintenance Tracking** — Log services, costs (TND), mileage, and set reminders
- **Service Providers** — Browse garages, filter by city/service, view ratings and reviews
- **Booking System** — 4-step flow: service > vehicle > date/time > confirm
- **Home Dashboard** — Primary vehicle summary, upcoming maintenance, recent bookings, quick actions
- **Offline-First** — Works without internet, syncs when connectivity is restored
- **Bilingual** — English + French (Arabic planned)

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (iOS + Android) |
| State Management | Riverpod 4.x + code gen |
| Routing | GoRouter 17.x with auth guards |
| Backend | Supabase (PostgreSQL, Auth, Storage) |
| Local DB | Drift (SQLite, offline-first) |
| Models | Freezed 3.x (immutable + serialization) |
| Error Handling | fpdart (Either pattern) |
| UI | Material 3 with custom theming |

## Getting Started

### Prerequisites

- Flutter SDK (3.38+)
- Dart SDK (3.10+)
- A Supabase project (see [schema migration](supabase/migrations/00001_initial_schema.sql))

### Setup

```bash
# Install dependencies
flutter pub get

# Run code generation
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run \
  --dart-define=SUPABASE_URL=your_url \
  --dart-define=SUPABASE_ANON_KEY=your_key
```

### Build

```bash
# Android
flutter build apk --debug

# iOS
flutter build ios --debug --no-codesign
```

## Project Structure

```
lib/
├── main.dart / bootstrap.dart / app.dart
├── core/           # constants, env, errors, extensions, utils
├── database/       # Drift DB + tables
├── l10n/           # app_en.arb, app_fr.arb
├── routing/        # GoRouter + bottom nav scaffold
├── theme/          # colors, spacing, Material 3 theme
├── shared/         # providers, reusable widgets
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

## Screens (20)

| Route | Screen |
|-------|--------|
| `/` | Splash |
| `/onboarding` | Onboarding |
| `/auth/login` | Login |
| `/auth/register` | Register |
| `/auth/forgot-password` | Forgot Password |
| `/home` | Home Dashboard |
| `/garage` | Vehicle List (My Garage) |
| `/garage/add` | Add Vehicle |
| `/garage/:id` | Vehicle Detail |
| `/garage/:id/edit` | Edit Vehicle |
| `/garage/:id/maintenance/add` | Add Maintenance |
| `/services` | Garages List |
| `/services/:id` | Garage Detail |
| `/services/:id/book` | Booking Flow |
| `/bookings` | Booking History |
| `/bookings/:id` | Booking Detail |
| `/profile` | Profile |
| `/profile/edit` | Edit Profile |

## Tunisia-Specific

- TND currency formatting (3 decimal places)
- Phone validation (+216 format)
- Tunisian plate number validation
- 24 governorates for location fields
- Popular local car brands: Peugeot, Renault, Citroen, VW, SEAT, Fiat, Hyundai, Kia, Toyota

## License

Private — All rights reserved.
