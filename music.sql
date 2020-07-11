-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE artists (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE producers (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE albums (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL
);

CREATE TABLE songs (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  release_date DATE NOT NULL,
  artist INTEGER REFERENCES artists ON DELETE CASCADE,
  featured_artist INTEGER REFERENCES artists ON DELETE CASCADE,
  album INTEGER REFERENCES albums ON DELETE CASCADE,
  producer INTEGER REFERENCES producers ON DELETE CASCADE,
  coproducer INTEGER REFERENCES producers ON DELETE CASCADE
);

-- Seed Database
INSERT INTO artists (name)
  VALUES
    ('Hanson'),
    ('Queen'),
    ('Mariah Carey'),
    ('Boyz II Men'),
    ('Lady Gaga'),
    ('Bradley Cooper'),
    ('Nickelback'),
    ('Jay Z'),
    ('Alicia Keys'),
    ('Katy Perry'),
    ('Juicy J'),
    ('Maroon 5'),
    ('Christina Aguilera'),
    ('Avril Lavigne'),
    ('Destiny''s Child');

INSERT INTO producers (name)
  VALUES
    ('Dust Brothers'),
    ('Stephen Lironi'),
    ('Roy Thomas Baker'),
    ('Walter Afanasieff'),
    ('Benjamin Rice'),
    ('Rick Parashar'),
    ('Al Shux'),
    ('Max Martin'),
    ('Cirkut'),
    ('Shellback'),
    ('Benny Blanco'),
    ('The Matrix'),
    ('Darkchild');

INSERT INTO albums (title)
  VALUES
    ('Middle of Nowhere'),
    ('A Night at the Opera'),
    ('Daydream'),
    ('A Star Is Born'),
    ('Silver Side Up'),
    ('The Blueprint 3'),
    ('Prism'),
    ('Hands All Over'),
    ('Let Go'),
    ('The Writing''s on the Wall');


INSERT INTO songs
  (title, duration_in_seconds, release_date, artist, album, producer, coproducer)
VALUES
  ('MMMBop', 238, '04-15-1997', 1, 1, 1, 2);

INSERT INTO songs
  (title, duration_in_seconds, release_date, artist, album, producer)
VALUES
  ('Bohemian Rhapsody', 355, '10-31-1975', 2, 2, 3),
  ('How You Remind Me', 223, '08-21-2001', 7, 5, 6),
  ('Complicated', 244, '05-14-2002', 14, 9, 12),
  ('Say My Name', 240, '11-07-1999', 15, 10, 13);

INSERT INTO songs
  (title, duration_in_seconds, release_date, artist, featured_artist, album, producer)
VALUES
  ('One Sweet Day', 282, '11-14-1995', 3, 4, 3, 4),
  ('Shallow', 216, '09-27-2018', 5, 6, 4, 5),
  ('New York State of Mind', 276, '10-20-2009', 8, 9, 6, 7);

INSERT INTO songs
  (title, duration_in_seconds, release_date, artist, featured_artist, album, producer, coproducer)
VALUES
  ('Dark Horse', 215, '12-17-2013', 10, 11, 7, 8, 9),
  ('Moves Like Jagger', 201, '06-21-2011', 12, 13, 8, 10, 11);


  -- Test Query
SELECT s.title AS song, a.name AS artist, fa.name AS featuring, al.title AS album, p.name AS producer, cp.name AS coproducer FROM songs s 
  JOIN artists a ON s.artist = a.id
  JOIN artists fa ON s.featured_artist = fa.id
  JOIN albums al ON s.album = al.id
  JOIN producers p ON s.producer = p.id
  JOIN producers cp ON s.coproducer = cp.id;
