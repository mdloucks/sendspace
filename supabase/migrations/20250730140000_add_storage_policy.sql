-- Create the bucket if it doesn't already exist
insert into storage.buckets (id, name, public)
values ('post_videos', 'post_videos', true)
on conflict (id) do nothing;

-- Drop the policy if it already exists (optional but good for idempotency)
drop policy if exists "Authenticated users can upload to post_videos" on storage.objects;

-- Create a policy allowing authenticated users to insert into post_videos bucket
create policy "Authenticated users can upload to post_videos"
  on storage.objects
  for insert
  with check (
    bucket_id = 'post_videos' AND auth.role() = 'authenticated'
  );

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
