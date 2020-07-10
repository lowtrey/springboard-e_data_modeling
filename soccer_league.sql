-- Design a schema for a simple sports league. 
-- Your schema should keep track of:
--    All of the teams in the league
--    All of the goals scored by every player for each game
--    All of the players in the league and their corresponding teams
--    All of the referees who have been part of each game
--    All of the matches played between teams
--    All of the start and end dates for season that a league has
--    The standings/rankings of each team in the league 
--    (This doesn’t have to be its own table if the data can be captured somehow).

DROP DATABASE IF EXISTS soccer_league;

CREATE DATABASE soccer_league;

\c soccer_league;

CREATE TABLE teams (
  id SERIAL PRIMARY KEY,
  name VARCHAR(30),
  city VARCHAR(30),
  stadium VARCHAR(30),
  coach VARCHAR(30),
  current_ranking INTEGER UNIQUE NOT NULL
);

CREATE TABLE seasons (
  id SERIAL PRIMARY KEY,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  champion INTEGER REFERENCES teams ON DELETE CASCADE
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
  home_score INTEGER NOT NULL,
  away_team INTEGER REFERENCES teams ON DELETE CASCADE,
  away_score INTEGER NOT NULL,
  referee INTEGER REFERENCES referees ON DELETE CASCADE
);
 
CREATE TABLE goals (
  id SERIAL PRIMARY KEY,
  player INTEGER REFERENCES players ON DELETE CASCADE,
  match INTEGER REFERENCES matches ON DELETE CASCADE, 
  match_time INTERVAL NOT NULL
);

		
-- Seed Database
INSERT INTO teams (name, city, stadium, coach, current_ranking)
  VALUES
    ('Atalanta', 'Bergamo', 'Gewiss Stadium', 'Gian Piero Gasperini', 3),
    ('Bologna', 'Bologna', 'Stadio Renato Dall''Ara', 'Siniša Mihajlović', 10),
    ('Brescia', 'Brescia', 'Stadio Mario Rigamonti', 'Diego López', 19),
    ('Cagliari', 'Cagliari', 'Sardegna Arena', 'Walter Zenga', 11),
    ('Fiorentina', 'Florence', 'Stadio Artemio Franchi', 'Giuseppe Iachini', 13),
    ('Genoa', 'Genoa', 'Stadio Luigi Ferraris', 'Davide Nicola', 18),
    ('Hellas Verona', 'Verona', 'Stadio Marc''Antonio Bentegodi', 'Ivan Jurić', 9),
    ('Inter Milan', 'Milan', 'San Siro', 'Antonio Conte', 4),
    ('Juventus', 'Turin', 'Allianz Stadium', 'Maurizio Sarri', 1),
    ('Lazio', 'Rome', 'Stadio Olimpico', 'Simone Inzaghi', 2),
    ('Lecce', 'Lecce', 'Stadio Via del Mare', 'Fabio Liverani', 17),
    ('A.C. Milan', 'Milan', 'San Siro', 'Stefano Pioli', 7),
    ('Napoli', 'Naples', 'Stadio San Paolo', 'Gennaro Gattuso', 6),
    ('Parma', 'Parma', 'Stadio Ennio Tardini', 'Roberto D''Aversa', 12),
    ('Roma', 'Rome', 'Stadio Olimpico', 'Paulo Fonseca', 5),
    ('Sampdoria', 'Genoa', 'Stadio Luigi Ferraris', 'Claudio Ranieri', 16),
    ('Sassuolo', 'Sassuolo', 'Mapei Stadium', 'Roberto De Zerbi', 8),
    ('SPAL', 'Ferrara', 'Stadio Paolo Mazza', 'Luigi Di Biagio', 20),
    ('Torino', 'Turin', 'Stadio Olimpico Grande Torino', 'Moreno Longo', 15),
    ('Udinese', 'Udine', 'Stadio Friuli', 'Luca Gotti', 14);


INSERT INTO seasons (start_date, end_date, champion)
  VALUES
    ('2011-09-03', '2012-05-13', 9),
    ('2012-08-25', '2013-05-19', 9),
    ('2013-08-24', '2014-05-18', 9),
    ('2014-08-30', '2015-05-31', 9),
    ('2015-08-22', '2016-05-15', 9),
    ('2016-08-20', '2017-05-28', 9),
    ('2017-08-19', '2018-05-20', 9),
    ('2018-08-18', '2019-05-26', 9);


INSERT INTO players (name, position, jersey_number, team)
  VALUES
    ('Ciro Immobile', 'Striker', 17, 10),
    ('Cristiano Ronaldo', 'Forward', 7, 9),
    ('Romelu Lukaku', 'Striker', 9, 8),
    ('Luis Muriel', 'Forward', 9, 1),
    ('João Pedro', 'Midfielder', 10, 4),
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


INSERT INTO matches (home_team, home_score, away_team, away_score, referee)
  VALUES
    (9, 3, 2, 0, 1);

INSERT INTO goals (player, match, match_time)
  VALUES
    (2, 1, '20m 05s'),
    (2, 1, '45m 30s'),
    (2, 1, '58m 38s');


-- Test Query
SELECT match_time, p.name AS player, p.position, t.name AS team FROM goals g
  JOIN matches m
  ON g.match = m.id
  JOIN players p
  ON g.player = p.id
  JOIN teams t 
  ON p.team = t.id;