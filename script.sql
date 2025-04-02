-- STEP 2
-- Create users database
CREATE TABLE users(
    id_user INTEGER PRIMARY KEY AUTOINCREMENT,
    firstname TEXT NOT NULL,
    lastname TEXT NOT NULL,
    email TEXT NOT NULL
);

-- Create edusign database with id_user form users database as a foreign key
CREATE TABLE edusign(
    id_signature INTEGER PRIMARY KEY,
    created_at DATETIME NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id)
    REFERENCES users(id_user)
);

-- Insert some data
INSERT INTO users (firstname, lastname, email) 
VALUES 
('Ada', 'Lovelace', 'ada@test.fr'),
('Pamela', 'Robinet', 'pamela.rob@gmail.com'),
('Auriane', 'Bourguenolle', 'auriane44@free.fr'),
('Michel', 'Lheriteau', 'mimilheriteau@hey.com'),
('Camille', 'Fasani', 'camille.fasani@orange.fr');

--Again
INSERT INTO users (firstname, lastname, email) VALUES ('Beatrice', 'Worsley', 'bea@test.fr');
INSERT INTO users (firstname, lastname, email) VALUES ('Bella', 'Guerin', 'bella@test.fr');
INSERT INTO users (firstname, lastname, email) VALUES ('Barbara', 'Chase', 'barbara@test.fr');

--STEP 3 Niveau facile
--1 Sélectionner toutes les lignes de la table users
SELECT * FROM users;

--2 Sélectionner uniquement la ligne où le prénom est Ada dans la table users
SELECT * FROM users WHERE firstname = 'Ada';

--3 Sélectionner les lignes dont la première lettre du prénom est un B dans la table users
SELECT * FROM users WHERE firstname LIKE 'B%';

--4 Compter le nombre de lignes dans la table users
SELECT count(*) FROM users;

--5 Compter le nombre de lignes dont la première lettre du prénom est un B dans la table users
SELECT count(*) FROM users WHERE firstname LIKE 'B%';

--6 Afficher uniquement la colonne contenant le prénom de la table users.  
SELECT firstname FROM users;

--STEP 4 Niveau Moyen

--1 Insérer une ligne dans la table edusign qui correspond à la user Ada avec comme date de signature le 2024-05-30 09:30:00
INSERT INTO edusign (created_at, user_id)
VALUES ('2024-05-30 09:30:00', 1);

--2 Insérer une ligne dans la table edusign qui correspond à la user Bella avec comme date de signature le 2024-05-30 09:30:00
INSERT INTO edusign (created_at, user_id)
VALUES ('2024-05-30 09:30:00', 7);

--3 Insérer toutes les lignes de la table users dans la table edusign avec pour date de signature le 2024-09-01 09:30:00
INSERT INTO edusign (user_id, created_at)
SELECT id_user, '2024-09-01 09:30:00' 
FROM users;

--4 Sélectionner toutes les lignes de la table edusign ordonnées par date de signature de la plus récente à la plus ancienne et par user_id ascendant.
SELECT * FROM edusign
ORDER BY 
    created_at DESC, 
    user_id ASC;

--5 Sélectionner toutes les lignes de la table edusign dont la date est 2024-05-30 09:30:00
SELECT * FROM edusign
WHERE created_at = '2024-05-30 09:30:00';

--STEP 5 Niveau Moyen + (bonus)

--1 Dans la table edusign, afficher le nombre d’apprenantes par date.
SELECT created_at, count(user_id) 
FROM edusign
GROUP BY created_at;

--2 Compter le nombre de lignes au sein de la table edusign dont le prénom est Bella, le nom de la colonne finale doit être volume
SELECT 
    users.firstname, 
    COUNT(*) AS volume
FROM 
    edusign
JOIN 
    users ON edusign.user_id = users.id_user
WHERE 
    users.firstname = 'Bella'
GROUP BY 
    users.firstname;