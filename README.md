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
