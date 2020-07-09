-- Design the schema for a medical center.
-- A medical center employs several doctors
-- A doctors can see many patients
-- A patient can be seen by many doctors
-- During a visit, a patient may be diagnosed to have one or more diseases.

DROP DATABASE IF EXISTS medical_center;

CREATE DATABASE medical_center;

\c medical_center

CREATE TABLE doctors (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);


CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  age INTEGER NOT NULL,
  height_in_inches INTEGER NOT NULL,
  weight_in_pounds INTEGER NOT NULL
);


CREATE TABLE diseases (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  severity TEXT NOT NULL
);


CREATE TABLE visits (
  id SERIAL PRIMARY KEY,
  date DATE NOT NULL,
  doctor_id INTEGER REFERENCES doctors ON DELETE SET NULL,
  patient_id INTEGER REFERENCES patients ON DELETE SET NULL
);


CREATE TABLE diagnoses (
  id SERIAL PRIMARY KEY,
  visit_id INTEGER REFERENCES visits ON DELETE SET NULL,
  disease_id INTEGER REFERENCES diseases ON DELETE SET NULL
);


-- Seed Database
INSERT INTO doctors (name)
  VALUES
    ('Curtis Trueblood'),
    ('Tiffany Arnold'),
    ('James Johnson'),
    ('Sarah Webber'),
    ('Marcus Hayes'),
    ('Justin Hayes');


INSERT INTO patients (name, age, height_in_inches, weight_in_pounds)
  VALUES
    ('Jennifer Lawson', 28, 59, 110),
    ('Fred Barksdale', 60, 69, 225),
    ('Susan Simpson', 29, 65, 150),
    ('Lisa Roberts', 37, 70, 168),
    ('Sonny Liston', 55, 68, 235),
    ('Luke Maxwell', 30, 69, 200),
    ('Mya Richards', 22, 60, 140),
    ('Lloyd James', 45, 69, 300),
    ('Tim Harden', 18, 66, 145),
    ('Mike Tyson', 50, 65, 220);


INSERT INTO visits (date, doctor_id, patient_id)
  VALUES 
    ('2020-02-12', 4, 10),
    ('2020-02-17', 1, 1),
    ('2020-01-20', 2, 2),
    ('2020-01-15', 3, 3),
    ('2020-04-04', 4, 4),
    ('2020-03-11', 5, 5),
    ('2020-02-20', 6, 6),
    ('2020-06-25', 1, 7),
    ('2020-07-16', 2, 8),
    ('2020-05-01', 3, 9),
    ('2020-05-08', 5, 1),
    ('2020-02-26', 6, 2),
    ('2020-01-30', 1, 3),
    ('2020-04-17', 2, 4),
    ('2020-06-22', 3, 5);


INSERT INTO diseases (name, severity)
  VALUES
    ('multiple sclerosis', 'high'),
    ('alzheimers', 'medium'),
    ('bronchitis', 'medium'),
    ('strep throat', 'low'),
    ('dementia', 'medium'),
    ('parkinsons', 'high'),
    ('halitosis', 'high'),
    ('diabetes', 'high'),
    ('asthma', 'high'),
    ('covid', 'high'),
    ('lupus', 'high'),
    ('crabs', 'low'),
    ('HIV', 'high'),
    ('mono', 'low'),
    ('rash', 'low');


INSERT INTO diagnoses (visit_id, disease_id)
  VALUES
    (1, 15),
    (2, 14),
    (3, 13),
    (4, 12),
    (5, 11),
    (6, 10),
    (7, 9),
    (8, 8),
    (9, 7),
    (10, 6),
    (11, 5),
    (12, 4),
    (13, 3),
    (14, 2),
    (15, 1);


-- Test Query
SELECT date, doc.name AS doctor_name, p.name AS patient_name, dis.name AS disease_name, dis.severity 
  FROM diagnoses dia
  JOIN visits v ON dia.visit_id = v.id  
  JOIN diseases dis ON dia.disease_id = dis.id
  JOIN doctors doc ON v.doctor_id = doc.id
  JOIN patients p ON v.patient_id = p.id;