-- === 5. ZÁKLADNÍ CRUD DOTAZY ===

-- 1. SELECT – všechny položky včetně názvu kategorie
SELECT p.nazev, k.nazev AS kategorie, p.datum_expirace, p.pocet_kusu 
FROM polozka p JOIN kategorie k ON p.id_kategorie = k.id_kategorie;

-- 2. INSERT – přidej novou položku
INSERT INTO polozka (nazev, id_kategorie, datum_expirace, pocet_kusu) 
VALUES ('Nanuk Míša', 7, '2026-06-20', 10);

-- 3. UPDATE – změň počet kusů u položky s ID 5
UPDATE polozka SET pocet_kusu = 10 WHERE id_polozka = 5;

-- 4. UPDATE – změň datum expirace u položky s ID 1
UPDATE polozka SET datum_expirace = '2027-01-01' WHERE id_polozka = 1;

-- 5. DELETE – odstraň položku podle ID
DELETE FROM polozka WHERE id_polozka = 15;


-- === 6. POKROČILÉ SQL DOTAZY ===

-- 1. JOIN + WHERE – expirace do 30 dnů
SELECT nazev, datum_expirace FROM polozka 
WHERE datum_expirace <= DATE_ADD('2026-01-09', INTERVAL 30 DAY);

-- 2. Agregace – celkový počet kusů v mrazáku
SELECT SUM(pocet_kusu) AS celkovy_pocet_vseho FROM polozka;

-- 3. GROUP BY + COUNT – počet položek v kategoriích
SELECT k.nazev, COUNT(p.id_polozka) AS pocet_druhu 
FROM kategorie k LEFT JOIN polozka p ON k.id_kategorie = p.id_kategorie 
GROUP BY k.nazev;

-- 4. MIN / MAX – nejbližší a nejvzdálenější expirace
SELECT MIN(datum_expirace) AS nejdriv_vyhodit, MAX(datum_expirace) AS nejdele_vydrzi 
FROM polozka;

-- 5. UNION – expirace do 14 dnů NEBO méně než 2 kusy
(SELECT nazev, 'Brzy vyprší' AS duvod FROM polozka WHERE datum_expirace <= DATE_ADD('2026-01-09', INTERVAL 14 DAY))
UNION
(SELECT nazev, 'Dochází' AS duvod FROM polozka WHERE pocet_kusu < 2);