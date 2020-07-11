-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE passengers (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE countries (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE cities (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  country INTEGER REFERENCES countries ON DELETE CASCADE
);

CREATE TABLE airlines (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  airline INTEGER REFERENCES airlines ON DELETE CASCADE,
  from_city INTEGER REFERENCES cities ON DELETE CASCADE,
  to_city INTEGER REFERENCES cities ON DELETE CASCADE
);

CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  passenger INTEGER REFERENCES passengers ON DELETE CASCADE, 
  flight INTEGER REFERENCES flights ON DELETE CASCADE,
  seat TEXT NOT NULL
);

INSERT INTO passengers (name)
  VALUES
    ('Jennifer Finch'),
    ('Thadeus Gathercoal'),
    ('Sonja Pauley'),
    ('Jennifer Finch'),
    ('Waneta Skeleton'),
    ('Thadeus Gathercoal'),
    ('Berkie Wycliff'),
    ('Alvin Leathes'),
    ('Berkie Wycliff'),
    ('Cory Squibbes');

INSERT INTO countries (name)
  VALUES
    ('United States'),
    ('Japan'),
    ('United Kingdom'),
    ('Mexico'),
    ('France'),
    ('Morocco'),
    ('UAE'),
    ('China'),
    ('Brazil'),
    ('Chile');

INSERT INTO cities (name, country)
  VALUES
    ('Washington DC', 1),
    ('Seattle', 1),
    ('Los Angeles', 1),
    ('Las Vegas', 1),
    ('New York', 1),
    ('Charlotte', 1),
    ('Cedar Rapids', 1),
    ('Chicago', 1),
    ('New Orleans', 1),
    ('Tokyo', 2),
    ('London', 3),
    ('Mexico City', 4),
    ('Paris', 5),
    ('Casablanca', 6),
    ('Dubai', 7),
    ('Beijing', 8),
    ('Sao Paolo', 9),
    ('Santiago', 10);

INSERT INTO airlines (name)
  VALUES
    ('United'),
    ('British Airways'),
    ('Delta'),
    ('TUI Fly Belgium'),
    ('Air China'),
    ('American Airlines'),
    ('Avianca Brasil');

INSERT INTO flights (departure, arrival, airline, from_city, to_city)
  VALUES
    ('2018-04-08 09:00:00', '2018-04-08 12:00:00', 1, 1, 2),
    ('2018-12-19 12:45:00', '2018-12-19 16:15:00', 2, 10, 11),
    ('2018-01-02 07:00:00', '2018-01-02 08:03:00', 3, 3, 4),
    ('2018-04-15 16:50:00', '2018-04-15 21:00:00', 3, 2, 12),
    ('2018-08-01 18:30:00', '2018-08-01 21:50:00', 4, 13, 14),
    ('2018-10-31 01:15:00', '2018-10-31 12:55:00', 5, 15, 16),
    ('2019-02-06 06:00:00', '2019-02-06 07:47:00', 1, 5, 6),
    ('2018-12-22 14:42:00', '2018-12-22 15:56:00', 6, 7, 8),
    ('2019-02-06 16:28:00', '2019-02-06 19:18:00', 6, 6, 9),
    ('2019-01-20 19:30:00', '2019-01-20 22:45:00', 7, 17, 18);

INSERT INTO tickets (passenger, flight, seat)
  VALUES
    (1, 1, '33B'),
    (2, 2, '8A'),
    (3, 3, '12F'),
    (4, 4, '20A'),
    (5, 5, '23D'),
    (6, 6, '18C'),
    (7, 7, '9E'),
    (8, 8, '1A'),
    (9, 9, '32B'),
    (10, 10, '10D');


-- Test Queries
SELECT departure, arrival, a.name AS airline, fc.name AS from_city, tc.name AS to_city FROM flights f
  JOIN airlines a 
  ON f.airline = a.id
  JOIN cities fc
  ON f.from_city = fc.id
  JOIN cities tc 
  ON f.to_city = tc.id;

SELECT p.name AS passenger, seat, a.name AS airline, fc.name AS from, departure, tc.name AS to, arrival FROM tickets t
  JOIN passengers p 
  ON t.passenger = p.id
  JOIN flights f 
  ON t.flight = f.id
  JOIN airlines a 
  ON f.airline = a.id
  JOIN cities fc 
  ON f.from_city = fc.id
  JOIN cities tc 
  ON f.to_city = tc.id;