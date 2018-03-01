CREATE TABLE album (
    album_id INTEGER PRIMARY KEY,
    album_title VARCHAR(155) NOT NULL,
    release_date DATETIME NOT NULL,
    genre VARCHAR(155) NOT NULL
);

CREATE TABLE person (
   card_number CHAR(36) PRIMARY KEY, -- UUID field
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

-- NOTE: both `checkout_date` and `card_number` will be present if checked out,
-- both will be `NULL` if not checked out
CREATE TABLE media (
    media_id INTEGER PRIMARY KEY,
    type VARCHAR(8) NOT NULL,
    checkout_date DATETIME, -- will only be present if checked out
    album_id REFERENCES album(album_id) NOT NULL,
    card_number REFERENCES person(card_number) -- will only be present if checked out
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
