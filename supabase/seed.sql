INSERT INTO
    auth.users (
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
    ) (
        select
            '00000000-0000-0000-0000-000000000000',
            uuid_generate_v4 (),
            'authenticated',
            'authenticated',
            'user' || (ROW_NUMBER() OVER ()) || '@example.com',
            crypt ('password123', gen_salt ('bf')),
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
        FROM
            generate_series(1, 10)
    );
	
-- test user email identities
INSERT INTO
    auth.identities (
        id,
        user_id,
        -- New column
        provider_id,
        identity_data,
        provider,
        last_sign_in_at,
        created_at,
        updated_at
    ) (
        select
            uuid_generate_v4 (),
            id,
            -- New column
            id,
            format('{"sub":"%s","email":"%s"}', id :: text, email) :: jsonb,
            'email',
            current_timestamp,
            current_timestamp,
            current_timestamp
        from
            auth.users
    );

INSERT INTO climb_types (id, name)
VALUES
  (gen_random_uuid(), 'Bouldering'),
  (gen_random_uuid(), 'Top Rope'),
  (gen_random_uuid(), 'Lead Climbing');


-- Get a UUID from an existing climb type first
-- Replace with your actual climb_type_id and user_id
INSERT INTO posts (id, title, description, video_url, coordinates, grade, user_id, climb_type_id)
VALUES (
  gen_random_uuid(),
  'First V5',
  'Sent it after 4 tries on overhung wall.',
  'https://example.com/video1.mp4',
  tiger.st_point(-83.117093, 42.519011),
  'V5',
  (SELECT id from auth.users where email = 'user1@example.com' LIMIT 1),
  (SELECT id FROM climb_types WHERE name = 'Bouldering' LIMIT 1)
);


-- Create a second user to follow the first one
--INSERT INTO auth.users (id, email, encrypted_password)
--VALUES (
--    '22222222-2222-2222-2222-222222222222',
--    'follower@example.com',
--    crypt('password456', gen_salt('bf'))
--);

