# Glint

Glint is a dating app designed to be interactive and being able to find someone like you are at a speed dating show.

### Tech Stack

- Flutter
- Supabase

### Libraries

- Riverpod
- Supabase

### How to run locally

- Get packages `flutter pub get`
- Run `flutter run`

### How to do schema migration

- `cd database/`
- `supabase init`
- `supabase link --project-ref $PROJECT_ID`
- `supabase db pull` - pulls the schema but not Auth and Storage
- `npx supabase db pull --schema auth,storage` - pulls Auth & Storage

Change to prod database

- `supabase link --project-ref $PROJECT_ID`
- `supabase start`
- `supabase reset`
- `supabase db push`

### How to build app

#### Run

- `flutter run lib/main.dart --dart-define=SUPABASE_URL=url --dart-define=SUPABASE_ANNON_KEY=key`

#### Build

- `flutter build web lib/main.dart --dart-define=SUPABASE_URL=url --dart-define=SUPABASE_ANNON_KEY=key`

https://xpkwqnlgvbdkoizpkqbf.supabase.co

eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhwa3dxbmxndmJka29penBrcWJmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc0MzE5NTUsImV4cCI6MjAzMzAwNzk1NX0.uHMSgmqBUCkRh-drLZapBwqnlOyNsRXqTiLFnysc7nI
