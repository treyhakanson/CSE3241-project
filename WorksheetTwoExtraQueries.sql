-- See Checkpoint3.docx for plain english/relational algebra

-- Query 1
SELECT first_name || ' ' || last_name, COUNT(*)
    FROM person p
        JOIN feedback f ON p.card_number = f.card_number
    GROUP BY p.card_number;

-- Query 2
SELECT album_title, AVG(stars)
   FROM review r
      JOIN album a ON a.album_id = r.album_id
   GROUP BY a.album_id;

-- Query 3
SELECT a.album_title, COUNT(*)
    FROM album a
        JOIN media m ON a.album_id = m.album_id
    GROUP BY a.album_id;
