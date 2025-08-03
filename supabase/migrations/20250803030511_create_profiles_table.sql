-- Create the profiles table linked to auth.users
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique,
  avatar_url text,
  bio text,
  created_at timestamp with time zone default timezone('utc', now())
);

-- Enable Row-Level Security
alter table public.profiles enable row level security;

-- Allow user to insert their own profile
create policy "Allow user to insert their own profile" on public.profiles
  for insert
  with check (auth.uid() = id);

-- Allow user to update their own profile
create policy "Allow user to update their own profile" on public.profiles
  for update
  using (auth.uid() = id);

-- Allow user to select their own profile
create policy "Allow user to select their own profile" on public.profiles
  for select
  using (auth.uid() = id);

-- Optional: allow public read access to all profiles (for public profile pages)
create policy "Allow anyone to read public profiles" on public.profiles
  for select
  using (true);
