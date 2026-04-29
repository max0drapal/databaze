-- 1. VYTVOŘENÍ DATABÁZE
CREATE DATABASE IF NOT EXISTS client_system CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE client_system;

-- 2. VYTVOŘENÍ TABULKY KLIENTŮ
CREATE TABLE IF NOT EXISTS CLIENTS (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(40) NOT NULL,
    lastname VARCHAR(60) NOT NULL,
    birthdate DATE NOT NULL,
    street VARCHAR(40) NOT NULL,
    housenum VARCHAR(10),
    postal VARCHAR(5),
    city VARCHAR(40),
    username VARCHAR(20) NOT NULL,
    passwd VARCHAR(128) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20)
);

-- 3. VYTVOŘENÍ TABULKY CERTIFIKÁTŮ
CREATE TABLE IF NOT EXISTS CERTIFICATES (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    clients_id INT UNSIGNED NOT NULL,
    certifkey VARCHAR(16) NOT NULL,
    UNIQUE (certifkey),
    CONSTRAINT fk_client_cert
        FOREIGN KEY (clients_id) 
        REFERENCES CLIENTS(id)
        ON DELETE CASCADE
);

-- 4. NAPLNĚNÍ FIKTIVNÍMI DATY
INSERT INTO CLIENTS (firstname, lastname, birthdate, street, housenum, postal, city, username, passwd, email, phone) 
VALUES
('Martin', 'Kopecký', '1990-03-15', 'Lipová', '12', '46001', 'Liberec', 'mkopec', 'pbkdf2:sha256:1000$randomhash', 'martin.k@email.cz', '+420722111333'),
('Jana', 'Nováková', '1985-11-20', 'Krátká', '5', '11000', 'Praha', 'jnovak01', 'pbkdf2:sha256:1000$anotherhash', 'jana@seznam.cz', '+420603444555'),
('Tomáš', 'Marný', '1998-07-02', 'Veselá', '458/3', '60200', 'Brno', 'tmarny', 'pbkdf2:sha256:1000$securepass', 'tomas.marny@gmail.com', '+420777888999');

INSERT INTO CERTIFICATES (clients_id, certifkey) 
VALUES
(1, 'ABC-123-XYZ-001'),
(1, 'ABC-123-XYZ-002'),
(2, 'CERT-99-OK-2026'),
(3, 'KEY-555-TRANS-X');

-- 5. KONTROLNÍ VÝPIS
SELECT 
    c.id AS 'ID Klienta',
    c.firstname AS 'Jméno',
    c.lastname AS 'Příjmení',
    c.city AS 'Město',
    cert.certifkey AS 'Klíč Certifikátu'
FROM CLIENTS c
LEFT JOIN CERTIFICATES cert ON c.id = cert.clients_id;