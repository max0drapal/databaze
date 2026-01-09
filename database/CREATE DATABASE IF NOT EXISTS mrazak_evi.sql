CREATE DATABASE IF NOT EXISTS mrazak_evidence;
USE mrazak_evidence;

CREATE TABLE kategorie (
    id_kategorie INT AUTO_INCREMENT PRIMARY KEY,
    nazev VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE polozka (
    id_polozka INT AUTO_INCREMENT PRIMARY KEY,
    nazev VARCHAR(100) NOT NULL,
    datum_expirace DATE NOT NULL,
    pocet_kusu INT NOT NULL,
    id_kategorie INT NOT NULL,
    CONSTRAINT check_pocet_kusu CHECK (pocet_kusu > 0),
    CONSTRAINT check_expirace CHECK (datum_expirace >= '2025-01-01'),
    FOREIGN KEY (id_kategorie) REFERENCES kategorie(id_kategorie)
);

INSERT INTO kategorie (nazev) VALUES 
('Maso'), ('Hotová jídla'), ('Ryby'), ('Zelenina'), 
('Přílohy'), ('Ovoce'), ('Dezerty'), ('Polotovary');

INSERT INTO polozka (nazev, id_kategorie, datum_expirace, pocet_kusu) VALUES
('Kuřecí prsa', 1, '2026-03-15', 4),
('Hovězí guláš', 2, '2026-01-20', 2),
('Losos filet', 3, '2026-02-10', 3),
('Mražený špenát', 4, '2026-06-01', 5),
('Hranolky', 5, '2026-05-12', 2),
('Jahody', 6, '2026-04-30', 3),
('Borůvky', 6, '2026-04-18', 2),
('Pizza Margherita', 2, '2026-02-28', 1),
('Vepřová panenka', 1, '2026-