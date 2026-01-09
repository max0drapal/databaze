-- 1. VYTVOŘENÍ DATABÁZE A TABULEK
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
    -- Podmínka: počet kusů musí být kladné celé číslo
    CONSTRAINT check_pocet_kusu CHECK (pocet_kusu > 0),
    -- Podmínka: datum expirace >= CURRENT_DATE
    CONSTRAINT check_expirace CHECK (datum_expirace >= '2025-01-01'),
    FOREIGN KEY (id_kategorie) REFERENCES kategorie(id_kategorie)
);

-- 2. NAPLNĚNÍ DATY
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
('Vepřová panenka', 1, '2026-03-05', 2),
('Zeleninová směs', 4, '2026-07-10', 4),
('Knedlíky', 5, '2026-08-01', 2),
('Vanilková zmrzlina', 7, '2026-09-15', 1),
('Rybí prsty', 3, '2026-01-30', 3),
('Maliny', 6, '2026-04-25', 2),
('Kuřecí vývar', 8, '2026-02-05', 4);

-- 3. POKROČILÉ DOTAZY PRO ODEVZDÁNÍ
-- Počet položek v jednotlivých kategoriích
SELECT k.nazev, COUNT(p.id_polozka) AS pocet_polozek
FROM kategorie k
LEFT JOIN polozka p ON k.id_kategorie = p.id_kategorie
GROUP BY k.nazev;

-- Položky s expirací do 14 dnů nebo s počtem kusů menším než 2
SELECT nazev, datum_expirace, pocet_kusu FROM polozka 
WHERE datum_expirace <= DATE_ADD('2026-01-09', INTERVAL 14 DAY) 
OR pocet_kusu < 2;