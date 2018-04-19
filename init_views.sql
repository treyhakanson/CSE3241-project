-- Number of checkouts all-time, grouped by album
CREATE VIEW IF NOT EXISTS checkout_info (
   album_title,
   genre,
   num_checkouts
) AS
   SELECT album_title,
          genre,
          COUNT(*) AS num_checkouts
      FROM checkout c
         JOIN media m ON c.media_id = m.media_id
         JOIN album a ON m.album_id = a.album_id
      GROUP BY album_title;

-- Average rating for albums with reviews
CREATE VIEW IF NOT EXISTS review_info (
   genre,
   avg_reviews
) AS
   SELECT album_title, AVG(stars)
      FROM review r
         JOIN album a ON a.album_id = r.album_id
      GROUP BY album_title;
