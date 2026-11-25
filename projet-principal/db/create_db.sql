CREATE DATABASE patientdb;

\c patientdb

CREATE TABLE patient (
    id              SERIAL PRIMARY KEY,
    nom             VARCHAR(100) NOT NULL,
    prenom          VARCHAR(100) NOT NULL,
    date_naissance  DATE,
    sexe            CHAR(1) CHECK (sexe IN ('M', 'F')),
    adresse         VARCHAR(255),
    telephone       VARCHAR(30),
    email           VARCHAR(150)
);

CREATE TABLE utilisateur (
    id            SERIAL PRIMARY KEY,
    login         VARCHAR(50)  NOT NULL UNIQUE,
    mot_de_passe  VARCHAR(100) NOT NULL,
    role          VARCHAR(20)  NOT NULL CHECK (role IN ('medecin', 'patient')),
    patient_id    INT REFERENCES patient(id) ON DELETE CASCADE
);

INSERT INTO patient (nom, prenom, date_naissance, sexe, adresse, telephone, email) VALUES
('Rakoto',  'Jean',  '1990-05-12', 'M', 'Antananarivo', '034 00 000 01', 'jean.rakoto@mail.com'),
('Rasoa',   'Marie', '1985-11-03', 'F', 'Antsirabe',    '034 00 000 02', 'marie.rasoa@mail.com'),
('Randria', 'Paul',  '2001-02-27', 'M', 'Toamasina',    '034 00 000 03', 'paul.randria@mail.com');

-- comptes de test (mots de passe en clair : OK pour un exercice, pas pour de la vraie production)
INSERT INTO utilisateur (login, mot_de_passe, role, patient_id) VALUES
('docteur', 'doc123', 'medecin', NULL),
('rakoto',  'pat123', 'patient', 1),
('rasoa',   'pat123', 'patient', 2);