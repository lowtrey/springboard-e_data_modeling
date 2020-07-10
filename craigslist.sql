-- Design a schema for Craigslist! Your schema should keep track of the following:
--   The region of the craigslist post (San Francisco, Atlanta, Seattle, etc)
--   Users and preferred region

-- Posts: 
--   contains title, text, the user who has posted, 
--   the location of the posting, the region of the posting,
--   categories that each post belongs to

DROP DATABASE IF EXISTS craigslist;

CREATE DATABASE craigslist;

\c craigslist

CREATE TABLE regions (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);


CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(20) NOT NULL
);


CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(30) NOT NULL,
  preferred_region INTEGER REFERENCES regions ON DELETE CASCADE
);
 

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  city VARCHAR(30) NOT NULL,
  title VARCHAR(30) NOT NULL,
  body VARCHAR(200) NOT NULL DEFAULT 'Under Construction...',
  author INTEGER REFERENCES users ON DELETE CASCADE,
  category INTEGER REFERENCES categories ON DELETE CASCADE
);


-- Seed Database
INSERT INTO regions (name)
  VALUES
    ('Dallas - Fort Worth'),
    ('Baton Rouge'),
    ('New Orleans'),
    ('Los Angeles'),
    ('Shreveport'),
    ('New York'),
    ('Atlanta'),
    ('Seattle'),
    ('Houston');


INSERT INTO categories (name)
  VALUES
    ('community'),
    ('services'),
    ('for sale'),
    ('housing'),
    ('jobs'),
    ('gigs');


INSERT INTO users (username, preferred_region)
  VALUES
    ('hack_or_snooze', 6),
    ('five_burroughs', 6),
    ('space_needles', 8),
    ('moosegoose321', 1),
    ('nunchucks6789', 5),
    ('cowboys4life', 1),
    ('geaux_tigers', 2),
    ('nola_darling', 3),
    ('ayy_bay_bay', 5),
    ('slim_jymmie', 2),
    ('space_ghost', 3),
    ('atl_shawty', 7),
    ('best_coast', 4),
    ('dr_danger', 4),
    ('h-tineeee', 9);


INSERT INTO posts (city, title, author, category)
  VALUES
    ('Scotlandville', 'Community Outreach', 7, 1),
    ('Kenner', 'Computer Repair Service', 8, 2),
    ('Arlington', 'Cheerleaders Needed', 6, 6),
    ('Alief', 'Slabs For Sale Yerdmeh', 15, 3),
    ('Fort Worth', 'Roclyn Apartments', 4, 4),
    ('Oakland', 'Steam Clean Service', 14, 2),
    ('Zachary', 'Townhomes Avail...', 10, 4),
    ('Metarie', 'Help Wanted...', 11, 5),
    ('Shreve', 'Selling This...', 9, 3),
    ('Brooklyn', 'NYC Community', 1, 1),
    ('Bossier City', 'Hiring...', 5, 5),
    ('Seattle', 'Selling my...', 3, 3),
    ('Buckhead', 'Gig work...', 12, 6),
    ('Compton', 'Community...', 13, 1),
    ('The Bronx', 'Services', 2, 2);


-- Test Query
SELECT city, r.name AS region, title, body, username, c.name AS category 
  FROM posts p
  JOIN users u ON p.author = u.id
  JOIN categories c ON p.category = c.id
  JOIN regions r ON u.preferred_region = r.id;