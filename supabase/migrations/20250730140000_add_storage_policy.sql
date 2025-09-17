-- Create the bucket if it doesn't already exist
insert into storage.buckets (id, name, public)
values ('post_videos', 'post_videos', true)
on conflict (id) do nothing;

drop policy if exists "Authenticated users can upload to post_videos" on storage.objects;

create policy "Authenticated users can upload to post_videos"
  on storage.objects
  for insert
  to authenticated
  with check (bucket_id = 'post_videos');

grant usage on schema tiger to authenticated;


-- Enable RLS (if not already done)
alter table posts enable row level security;

-- Create policy for authenticated users to insert into posts
create policy "Authenticated users can insert posts"
  on posts
  for insert
  to authenticated
  with check (
    auth.uid() = user_id
  );

-- For user profile pictures

-- Create the bucket if it doesn't already exist
insert into storage.buckets (id, name, public)
values ('users_profile_images', 'users_profile_images', true)
on conflict (id) do nothing;

-- Create a policy allowing authenticated users to insert into post_videos bucket
create policy "Authenticated users can upload to users_profile_images"
  on storage.objects
  for insert
  with check (
    bucket_id = 'users_profile_images' AND auth.role() = 'authenticated'
  );
