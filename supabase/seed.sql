-- Delete existing test data first
DELETE FROM auth.identities WHERE provider = 'email' AND identity_data->>'email' LIKE '%@example.com';
DELETE FROM auth.users WHERE email LIKE '%@example.com';

-- Create users with fixed UUIDs
INSERT INTO auth.users (
    instance_id,
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    recovery_sent_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    created_at,
    updated_at,
    confirmation_token,
    email_change,
    email_change_token_new,
    recovery_token
) VALUES 
-- user1@example.com with fixed UUID
(
    '00000000-0000-0000-0000-000000000000',
    '11111111-1111-1111-1111-111111111111',
    'authenticated',
    'authenticated',
    'user1@example.com',
    crypt('password123', gen_salt('bf')),
    current_timestamp,
    current_timestamp,
    current_timestamp,
    '{"provider":"email","providers":["email"]}',
    '{}',
    current_timestamp,
    current_timestamp,
    '',
    '',
    '',
    ''
),
-- user2@example.com with fixed UUID  
(
    '00000000-0000-0000-0000-000000000000',
    '22222222-2222-2222-2222-222222222222',
    'authenticated',
    'authenticated',
    'user2@example.com',
    crypt('password123', gen_salt('bf')),
    current_timestamp,
    current_timestamp,
    current_timestamp,
    '{"provider":"email","providers":["email"]}',
    '{}',
    current_timestamp,
    current_timestamp,
    '',
    '',
    '',
    ''
);

-- Create corresponding identities
INSERT INTO auth.identities (
    id,
    user_id,
    provider_id,
    identity_data,
    provider,
    last_sign_in_at,
    created_at,
    updated_at
) VALUES
(
    uuid_generate_v4(),
    '11111111-1111-1111-1111-111111111111',
    '11111111-1111-1111-1111-111111111111',
    '{"sub":"11111111-1111-1111-1111-111111111111","email":"user1@example.com"}'::jsonb,
    'email',
    current_timestamp,
    current_timestamp,
    current_timestamp
),
(
    uuid_generate_v4(),
    '22222222-2222-2222-2222-222222222222',
    '22222222-2222-2222-2222-222222222222',
    '{"sub":"22222222-2222-2222-2222-222222222222","email":"user2@example.com"}'::jsonb,
    'email',
    current_timestamp,
    current_timestamp,
    current_timestamp
);

-- Insert climb types
INSERT INTO climb_types (id, name)
VALUES
  (gen_random_uuid(), 'Bouldering'),
  (gen_random_uuid(), 'Top Rope'),
  (gen_random_uuid(), 'Lead Climbing')
ON CONFLICT (name) DO NOTHING;

-- Insert posts with the fixed user UUID
INSERT INTO posts (id, title, description, video_url, coordinates, grade, user_id, climb_type_id)
VALUES (
  gen_random_uuid(),
  'First V5',
  'Sent it after 4 tries on overhung wall.',
  'https://example.com/video1.mp4',
  tiger.st_point(-83.117093, 42.519011),
  'V5',
  '11111111-1111-1111-1111-111111111111', -- Fixed UUID for user1@example.com
  (SELECT id FROM climb_types WHERE name = 'Bouldering' LIMIT 1)
);


-- Create a second user to follow the first one
--INSERT INTO auth.users (id, email, encrypted_password)
--VALUES (
--    '22222222-2222-2222-2222-222222222222',
--    'follower@example.com',
--    crypt('password456', gen_salt('bf'))
--);


