-- Design a schema for a simple sports league. 
-- Your schema should keep track of

-- All of the teams in the league
-- All of the goals scored by every player for each game
-- All of the players in the league and their corresponding teams
-- All of the referees who have been part of each game
-- All of the matches played between teams
-- All of the start and end dates for season that a league has
-- The standings/rankings of each team in the league 
-- (This doesn’t have to be its own table if the data can be captured somehow).

DROP DATABASE IF EXISTS soccer_league;

CREATE DATABASE soccer_league;

\c soccer_league;

CREATE TABLE teams (
  id SERIAL PRIMARY KEY,
  name VARCHAR(30),
  city VARCHAR(30),
  stadium VARCHAR(30),
  coach VARCHAR(30)
);

CREATE TABLE players (
  id SERIAL PRIMARY KEY,
  name VARCHAR(30),
  position VARCHAR(30),
  jersey_number INTEGER,
  team INTEGER REFERENCES teams ON DELETE CASCADE 
);
 
CREATE TABLE referees (
  id SERIAL PRIMARY KEY,
  name VARCHAR(30),
  appearances INTEGER
);
 
CREATE TABLE matches (
  id SERIAL PRIMARY KEY,
  home_team INTEGER REFERENCES teams ON DELETE CASCADE,
  away_team INTEGER REFERENCES teams ON DELETE CASCADE,
  referee INTEGER REFERENCES referees ON DELETE CASCADE
);
 
CREATE TABLE goals (
  id SERIAL PRIMARY KEY,
  player INTEGER REFERENCES players ON DELETE CASCADE,
  match INTEGER REFERENCES matches ON DELETE CASCADE, 
  match_minutes FLOAT
);

		
-- Seed Database
INSERT INTO teams (name, city, stadium, coach)
  VALUES
    ('Atalanta', 'Bergamo', 'Gewiss Stadium', 'Gian Piero Gasperini'),
    ('Bologna', 'Bologna', 'Stadio Renato Dall''Ara', 'Siniša Mihajlović'),
    ('Brescia', 'Brescia', 'Stadio Mario Rigamonti', 'Diego López'),
    ('Cagliari', 'Cagliari', 'Sardegna Arena', 'Walter Zenga'),
    ('Fiorentina', 'Florence', 'Stadio Artemio Franchi', 'Giuseppe Iachini'),
    ('Genoa', 'Genoa', 'Stadio Luigi Ferraris', 'Davide Nicola'),
    ('Hellas Verona', 'Verona', 'Stadio Marc''Antonio Bentegodi', 'Ivan Jurić'),
    ('Inter Milan', 'Milan', 'San Siro', 'Antonio Conte'),
    ('Juventus', 'Turin', 'Allianz Stadium', 'Maurizio Sarri'),
    ('Lazio', 'Rome', 'Stadio Olimpico', 'Simone Inzaghi'),
    ('Lecce', 'Lecce', 'Stadio Via del Mare', 'Fabio Liverani'),
    ('A.C. Milan', 'Milan', 'San Siro', 'Stefano Pioli'),
    ('Napoli', 'Naples', 'Stadio San Paolo', 'Gennaro Gattuso'),
    ('Parma', 'Parma', 'Stadio Ennio Tardini', 'Roberto D''Aversa'),
    ('Roma', 'Rome', 'Stadio Olimpico', 'Paulo Fonseca'),
    ('Sampdoria', 'Genoa', 'Stadio Luigi Ferraris', 'Claudio Ranieri'),
    ('Sassuolo', 'Sassuolo', 'Mapei Stadium', 'Roberto De Zerbi'),
    ('SPAL', 'Ferrara', 'Stadio Paolo Mazza', 'Luigi Di Biagio'),
    ('Torino', 'Turin', 'Stadio Olimpico Grande Torino', 'Moreno Longo'),
    ('Udinese', 'Udine', 'Stadio Friuli', 'Luca Gotti');


INSERT INTO players (name, position, jersey_number, team)
  VALUES
    ('Ciro Immobile', 'Striker', 17, 10),
    ('Cristiano Ronaldo', 'Forward', 7, 9),
    ('Romelu Lukaku', 'Striker', 9, 8),
    ('Luis Muriel', 'Forward', 9, 1),
    ('João Pedro', 'Attacking Midfielder', 10, 4),
    ('Francesco Caputo', 'Striker', 9, 17),
    ('Josip Iličić', 'Forward', 72, 1),
    ('Andrea Belotti', 'Striker', 9, 19),
    ('Edin Džeko', 'Striker', 9, 15),
    ('Duván Zapata', 'Striker', 91, 1);


INSERT INTO referees (name, appearances)
  VALUES
    ('Maurizio Mariani', 17),
    ('Daniele Doveri', 16),
    ('Davide Massa', 16),
    ('Gianluca Rocchi', 15),
    ('Fabio Maresca', 15),
    ('Federico La Penna', 15),
    ('Rosario Abisso', 15),
    ('Daniele Orsato', 14),
    ('Gianpaolo Calvarese', 14),
    ('Piero Giacomelli', 14);