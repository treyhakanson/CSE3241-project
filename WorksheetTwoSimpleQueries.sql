-- 3a

-- 3b
SELECT album_title, release_date
FROM Album AS a
	JOIN Media AS m ON a.album_id = m.album_id
	JOIN Person AS p ON m.card_number = p.card_number
WHERE p.card_number = "ecc28cd1-0b49-4494-bcca-3b6d9027b63b"
-- 3c
-- 3d
SELECT album_title, first_name, last_name
FROM Album AS a
	JOIN Media AS m ON a.album_id = m.album_id
	JOIN Person AS p ON m.card_number = p.card_number
	JOIN Artist_Albums aa ON a.album_id = aa.album_id
	JOIN Artist a2 ON aa.artist_id = a2.artist_id
WHERE Artist.name = "AC/DC"

-- 3e

-- 3f
