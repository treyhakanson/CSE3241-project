CREATE TABLE album (
    album_id INTEGER PRIMARY KEY,
    album_title VARCHAR(155) NOT NULL,
    release_date DATETIME NOT NULL,
    genre VARCHAR(155) NOT NULL
);

CREATE TABLE person (
   card_number CHAR(36) PRIMARY KEY, -- UUID field
   email VARCHAR(155) UNIQUE,
   first_name VARCHAR(155) NOT NULL,
   last_name VARCHAR(155) NOT NULL,
   activation_date TIMESTAMP NOT NULL
);

CREATE TABLE artist (
    artist_id INTEGER PRIMARY KEY,
    name VARCHAR(155) NOT NULL
);

CREATE TABLE track (
    title VARCHAR(155) NOT NULL,
    album_id REFERENCES album(album_id) NOT NULL,
    number SMALLINT,
    length REAL NOT NULL,
    artist_id REFERENCES artist(artist_id) NOT NULL,
    PRIMARY KEY(title, album_id)
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
   due_date DATETIME NOT NULL,
   media_id INTEGER NOT NULL,
   card_number CHAR(36) NOT NULL
);

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
