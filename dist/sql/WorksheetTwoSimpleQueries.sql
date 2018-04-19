-- 3a
SELECT t.title
    FROM track t
        JOIN album a ON a.album_id = t.album_id
        JOIN artist_albums aa ON aa.album_id = a.album_id
        JOIN artist art ON art.artist_id = aa.artist_id
    WHERE name = 'AC/DC' AND
          release_date < 1982;

-- 3b
SELECT album_title, release_date
   FROM Album AS a
   	JOIN media AS m ON a.album_id = m.album_id
      JOIN checkout AS c ON m.media_id = c.media_id
   	JOIN person AS p ON p.card_number = c.card_number
   WHERE p.card_number = '7eddeba0-c2cc-4d7a-a1b1-7248c9dbda63';

-- 3c
SELECT a.album_id, a.album_title
    FROM album a
        JOIN media m ON a.album_id = m.album_id
    GROUP BY a.album_id
    HAVING COUNT(*) < 5;

-- 3d
SELECT album_title, first_name, last_name
   FROM Album AS a
   	JOIN Media AS m ON a.album_id = m.album_id
      JOIN checkout AS c ON m.media_id = c.media_id
   	JOIN Person AS p ON p.card_number = c.card_number
   	JOIN Artist_Albums aa ON a.album_id = aa.album_id
   	JOIN Artist a2 ON aa.artist_id = a2.artist_id
   WHERE a2.name = "AC/DC";

-- 3e
SELECT COUNT(*)
    FROM media AS m
        JOIN checkout AS c ON m.media_id = c.media_id
        JOIN person AS p ON p.card_number = c.card_number
        WHERE p.card_number = '7eddeba0-c2cc-4d7a-a1b1-7248c9dbda63';

-- 3f
SELECT full_name, MAX(count)
    FROM (
        SELECT first_name || ' ' || last_name full_name, COUNT(*) count
            FROM media m
                JOIN checkout AS c ON m.media_id = c.media_id
                JOIN person p ON p.card_number = c.card_number
            GROUP BY p.card_number
            ORDER BY COUNT(*) DESC
    );
