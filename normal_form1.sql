--READ IN THE CSV FILE
.mode csv
.import pokemon.csv imported_pokemon_data

--Recursive Solution
WITH split(name, abilities, nextability) AS (
	SELECT name, '' AS abilities, abilities || ',' AS  nextability
	FROM imported_pokemon_data
	UNION ALL
		SELECT name,
			substr(nextability, 0, instr(nextability, ',')) AS abilities,
			Substr(nextability, instr(nextability, ',') + 1) AS nextability
		FROM split
		WHERE nextability !='')
SELECT name, abilities
FROM split
WHERE abilities != ''
ORDER BY name;

--Cleaning up stuff
UPDATE imported_pokemon_data SET abilities = REPLACE(abilities, '[', ' ');
UPDATE imported_pokemon_data SET abilities = REPLACE(abilities, ']', ' ');
UPDATE imported_pokemon_data SET abilities = REPLACE(abilities, '''', ' ');
UPDATE imported_pokemon_data SET abilities = TRIM(abilities);