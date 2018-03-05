-- 3a
SELECT t.title
    FROM track t
        JOIN album a ON a.album_id = t.album_id
        JOIN artist_albums aa ON aa.album_id = a.album_id
        JOIN artist art ON art.artist_id = aa.artist_id
    WHERE name = 'AC/DC' AND
          release_date < 1982;

-- 3b

-- 3c
SELECT a.album_id, a.album_title
    FROM album a
        JOIN media m ON a.album_id = m.album_id
    GROUP BY a.album_id
    HAVING COUNT(*) < 5;

-- 3d

-- 3e
SELECT COUNT(*)
    FROM media m
        JOIN person p ON p.card_number = m.card_number
        WHERE p.card_number = '2f255b37-4c58-4da8-b98e-dec65365d56a';

-- 3f
SELECT full_name, MAX(count)
    FROM (
        SELECT first_name || ' ' || last_name full_name, COUNT(*) count
            FROM media m
                JOIN person p ON p.card_number = m.card_number
            GROUP BY p.card_number
            ORDER BY COUNT(*) DESC
    );
