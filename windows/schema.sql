CREATE TABLE album (
    album_id INTEGER PRIMARY KEY,
    album_title VARCHAR(155) NOT NULL,
    release_date DATETIME NOT NULL,
    genre VARCHAR(155) NOT NULL
);
CREATE TABLE artist (
    artist_id INTEGER PRIMARY KEY,
    name VARCHAR(155) NOT NULL
);
CREATE TABLE media (
    media_id INTEGER PRIMARY KEY,
    type VARCHAR(8) NOT NULL,
    album_id REFERENCES album(album_id) NOT NULL
);
CREATE TABLE checkout (
   checkout_id INTEGER PRIMARY KEY,
   checkout_date DATETIME NOT NULL,
   return_date DATETIME, -- `NULL` until returned
   media_id INTEGER NOT NULL,
   card_number CHAR(36) NOT NULL
, due_date DATETIME);
CREATE TABLE artist_albums (
    artist_id REFERENCES artist(artist_id) NOT NULL,
    album_id REFERENCES album(album_id) NOT NULL,
    PRIMARY KEY (artist_id, album_id)
);
CREATE TABLE employee (
    start_date DATETIME NOT NULL,
    salary REAL NOT NULL,
    position VARCHAR(155),
    card_number REFERENCES person(card_number) PRIMARY KEY
);
CREATE TABLE feedback (
    feedback_id INTEGER PRIMARY KEY,
    description VARCHAR(500) NOT NULL,
    date DATETIME NOT NULL,
    category VARCHAR(155) NOT NULL,
    card_number REFERENCES person(card_number) -- can be anonymous
);
CREATE TABLE review (
    review_id INTEGER PRIMARY KEY,
    stars SMALLINT NOT NULL,
    title VARCHAR(155), -- doesn't require a title
    description VARCHAR(500), -- doesn't require a description
    album_id REFERENCES album(album_id) NOT NULL,
    card_number REFERENCES person(card_number) -- can be anonymous
);
CREATE VIEW checkout_info (
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
CREATE VIEW review_info (
   genre,
   avg_reviews
) AS
   SELECT album_title, AVG(stars)
      FROM review r
         JOIN album a ON a.album_id = r.album_id
      GROUP BY album_title;
CREATE INDEX album_names ON album (album_title);
CREATE INDEX artist_names ON artist (name);
CREATE INDEX checkout_due_dates ON checkout (due_date);
CREATE INDEX checkout_return_dates ON checkout (return_date);
CREATE TABLE track (
    title VARCHAR(155) NOT NULL,
    album_id REFERENCES album(album_id) NOT NULL,
    number SMALLINT,
    length REAL NOT NULL,
    size_bytes BIGINT, -- library may not have a digital copy of a track, so may
                       -- be NULL
    PRIMARY KEY(title, album_id)
);
CREATE TABLE person (card_number CHAR (36) PRIMARY KEY, email VARCHAR (155) UNIQUE, first_name VARCHAR (155) NOT NULL, last_name VARCHAR (155) NOT NULL, activation_date TIMESTAMP NOT NULL, num_cards INTEGER NOT NULL DEFAULT (1), card_number_active BOOLEAN NOT NULL DEFAULT (0));
CREATE INDEX person_card_numbers ON person (card_number);
