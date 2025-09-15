-- Enable the uuid-ossp extension for UUID generation if not already enabled
create extension if not exists "uuid-ossp";

-- Create users table linked to auth.users
create table if not exists public.users (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null,
  user_name text not null,
  bio text,
  profile_image_url text,
  climbing_level text, -- e.g. V5, 5.11b, etc
  created_at timestamp with time zone default timezone('utc', now()) not null,
  updated_at timestamp with time zone default timezone('utc', now()) not null
);

-- Automatically update the `updated_at` column on update
create or replace function update_updated_at_column()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language 'plpgsql';

drop trigger if exists set_updated_at on public.users;
create trigger set_updated_at
before update on public.users
for each row
execute procedure update_updated_at_column();

-- Enable Row-Level Security
alter table public.users enable row level security;

-- Policy: Allow logged-in users to read any profile
create policy "Allow read access for all users"
on public.users
for select
using (true);

-- Policy: Allow a user to insert their own profile
create policy "Allow insert for authenticated users"
on public.users
for insert
with check (auth.uid() = id);

-- Policy: Allow a user to update their own profile
create policy "Allow update for profile owner"
on public.users
for update
using (auth.uid() = id);

-- Policy: Allow deleting own profile if needed (optional)
create policy "Allow delete for profile owner"
on public.users
for delete
using (auth.uid() = id);
