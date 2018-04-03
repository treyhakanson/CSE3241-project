-- checkouts for albums
CREATE VIEW IF NOT EXISTS album_checkouts(
   checkout_date,
   return_date,
   card_number,
   album_title
) AS
   SELECT checkout_date, return_date, card_number, album_title
      FROM checkout c
         JOIN media m ON c.media_id = m.media_id
         JOIN album a ON m.album_id = a.album_id;

-- reviews for albums
CREATE VIEW IF NOT EXISTS album_reviews(
   title,
   description,
   card_number,
   album_title
) AS
   SELECT title, description, card_number, album_title
      FROM review r
         JOIN album a ON r.album_id = r.album_id;
