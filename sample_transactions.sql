/*
 * Transaction to add a new album of tracks, by a new artist, into the database.
 */
BEGIN TRANSACTION;

INSERT INTO artist
VALUES
   (61, "Orikami Records");

INSERT INTO album
VALUES
   (109, "Orikami & Feels Compilation", "2018-02-23", "Hip Hop");

INSERT INTO artist_albums
VALUES
   (61, 109);

INSERT INTO track
VALUES
   ("Kazumi Kaneda", 109, 1, 3.3, 6600000),
   ("Madrob_Beats", 109, 2, 2.36, 4700000),
   ("Pandrezz", 109, 3, 2.16, 4100000),
   ("Mycatisflying", 109, 4, 1.65, 3500000),
   ("Shogonodo", 109, 5, 2.56, 4600000),
   ("Soryo", 109, 6, 2.72, 5000000),
   ("Rairakku", 109, 7, 2.97, 5700000),
   ("97SPECIAL", 109, 8, 1.36, 2800000),
   ("Rikinish & Tonguee", 109, 9, 2.4, 4000000),
   ("Thilonius", 109, 10, 2.23, 3800000),
   ("Saib.", 109, 11, 2.9, 5800000),
   ("Neptunien", 109, 12, 2.72, 5200000),
   ("TiMT & POD", 109, 13, 3.62, 7700000),
   ("j'san", 109, 14, 2.07, 3800000),
   ("Dhrma", 109, 15, 4.32, 8700000),
   ("Dayzero", 109, 16, 3.65, 6900000),
   ("Nymano", 109, 17, 2.5, 5100000);

COMMIT;

/*
 * Transaction to remove an artist and all associated content from the database.
 * (will delete the content created by the above transaction, so run that first)
 */
BEGIN TRANSACTION;

-- Temporarily store elements of pivot table that will be needed after they are
-- deleted (to avoid foreign key constraint errors)
CREATE TABLE temp_artist_albums (
   album_id INTEGER,
   artist_id INTEGER
);
INSERT INTO temp_artist_albums (album_id, artist_id)
   SELECT album_id, artist_id
      FROM artist_albums
      WHERE artist_id = 61;

-- Delete all tuples from the pivot table involving that artist
DELETE FROM artist_albums
   WHERE artist_id = 61;

-- Delete all tracks from albums by the specified artist
DELETE FROM track
   WHERE album_id IN (
      SELECT album_id
         FROM temp_artist_albums
         WHERE artist_id = 61
   );

-- Delete the artist from the database
DELETE FROM artist
   WHERE artist_id = 61;

-- Delete all albums by the specified artist
DELETE FROM album
   WHERE album_id IN (
      SELECT album_id
         FROM temp_artist_albums
         WHERE artist_id = 61
   );

-- Drop the temporary relation
DROP TABLE temp_artist_albums;

COMMIT;

/*
 * Transaction to create a new checkout for a given user
 */
BEGIN TRANSACTION;

INSERT INTO checkout (checkout_id, checkout_date, return_date, due_date, media_id, card_number)
   VALUES (100, date('now'), NULL, date('now', '+7 days'), 1, '18108a24-4eac-498d-a2d3-4dc4cccf405a');

COMMIT;

/*
 * Transaction to remove the "artist_id" column from the track table
 * (NOTE: running this won't do anything, as I already ran it to remove the
 * column before uploading; we had erroneously added an artist_id column
 * initially, and wrote this transaction to correct it)
 */
BEGIN TRANSACTION;

ALTER TABLE track RENAME TO temp_track;

CREATE TABLE track (
  title VARCHAR(155) NOT NULL,
  album_id REFERENCES album(album_id) NOT NULL,
  number SMALLINT,
  length REAL NOT NULL,
  size_bytes BIGINT, -- library may not have a digital copy of a track, so may
                     -- be NULL
  PRIMARY KEY(title, album_id)
);

INSERT INTO track (title, album_id, number, length, size_bytes)
   SELECT title, album_id, number, length, size_bytes
      FROM temp_track;

DROP TABLE temp_track;

COMMIT;
