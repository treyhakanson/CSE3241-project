-- 4a
SELECT full_name, SUM(length)
    FROM (
        SELECT first_name || ' ' || last_name full_name, p.card_number card_number, m.album_id media_album_id
            FROM media m
                JOIN person p ON p.card_number = m.card_number
    ) JOIN track t on media_album_id = t.album_id
    GROUP BY card_number;

-- 4b
SELECT first_name || ' ' || last_name full_name, email
   FROM person p
       JOIN checkout c ON c.card_number = p.card_number
   GROUP BY first_name, last_name, email
   HAVING COUNT(*) > (
       SELECT AVG(count)
           FROM (
               SELECT email, COUNT(*) count
                   FROM person p
                       JOIN checkout c ON c.card_number = p.card_number
                   GROUP BY email
           )
   );

-- 4c
SELECT album_title, COUNT(*)
    FROM album a
        JOIN media m ON a.album_id = m.album_id
        JOIN checkout c ON c.media_id = m.media_id
    WHERE return_date IS NULL
    GROUP BY album_title
    ORDER BY COUNT(*) DESC;

-- 4d
SELECT a.album_title, COUNT(*)
	FROM album a
    	JOIN media m ON a.album_id = m.album_id
        JOIN checkout c ON m.media_id = c.media_id
    GROUP BY a.album_title
    ORDER BY COUNT(*) DESC

-- 4e
SELECT name
    FROM album a
        JOIN media m ON a.album_id = m.album_id
        JOIN checkout c ON c.media_id = m.media_id
        JOIN artist_albums aa ON aa.album_id = a.album_id
        JOIN artist art ON art.artist_id = aa.artist_id
    WHERE return_date IS NULL
    GROUP BY name
    ORDER BY COUNT(*) DESC
    LIMIT 1;

-- 4f
SELECT name
    FROM album a
        JOIN media m ON a.album_id = m.album_id
        JOIN checkout c ON c.media_id = m.media_id
        JOIN artist_albums aa ON aa.album_id = a.album_id
        JOIN artist art ON art.artist_id = aa.artist_id
        JOIN track t ON t.album_id = a.album_id
    GROUP BY name
    ORDER BY SUM(length) DESC
    LIMIT 1;

-- 4g
SELECT card_number, email, first_name || ' ' || last_name full_name
    FROM person p
        JOIN checkout c ON p.card_number = c.card_number
        JOIN media m ON c.media_id = m.media_id
        JOIN album a ON a.album_id = m.album_id
        JOIN artist_albums aa ON a.album_id = aa.album_id
        JOIN artist art ON aa.artist_id = art.artist_id
    WHERE (
        SELECT name
            FROM album a
                JOIN media m ON a.album_id = m.album_id
                JOIN checkout c ON c.media_id = m.media_id
                JOIN artist_albums aa ON aa.album_id = a.album_id
                JOIN artist art ON art.artist_id = aa.artist_id
                JOIN track t ON t.album_id = a.album_id
            GROUP BY name
            ORDER BY SUM(length) DESC
            LIMIT 1
    ) LIKE art.name;

-- 4h
SELECT DISTINCT name
    FROM checkout c
        JOIN media m ON m.media_id = c.media_id
        JOIN artist_albums aa ON aa.album_id = m.album_id
        JOIN artist art ON art.artist_id = aa.artist_id
    WHERE c.card_number IN (
        SELECT p.card_number
           FROM person p
               JOIN checkout c ON c.card_number = p.card_number
           GROUP BY first_name, last_name, email
           HAVING COUNT(*) > (
               SELECT AVG(count)
                   FROM (
                       SELECT email, COUNT(*) count
                           FROM person p
                               JOIN checkout c ON c.card_number = p.card_number
                           GROUP BY email
                   )
           )
    )
