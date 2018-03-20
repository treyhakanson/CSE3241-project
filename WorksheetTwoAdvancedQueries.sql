-- 4a
SELECT full_name, SUM(length)
    FROM (
        SELECT first_name || ' ' || last_name full_name, p.card_number card_number, m.album_id media_album_id
            FROM media m
                JOIN person p ON p.card_number = m.card_number
    ) JOIN track t on media_album_id = t.album_id
    GROUP BY card_number;

-- 4b
SELECT first_name, last_name, p.card_number 
	FROM person as p
		JOIN media as m ON p.card_number = m.card_number
    GROUP BY first_name, last_name, m.card_number
    HAVING COUNT(m.card_number) > AVG(m.card_number)

-- 4c

-- 4d
SELECT a.album_title, COUNT(*)
	FROM album a
    	JOIN media m ON a.album_id = m.album_id
        JOIN checkout c ON m.media_id = c.media_id
    GROUP BY a.album_title
    ORDER BY COUNT(*) DESC

-- 4e

-- 4f

-- 4g

-- 4h
