Maddie Baumgardner, Sruti Chigurupati, Trey Hakanson, Elizabeth Gilbert
CSE 3421
04/20/2018
Final Project User Guide

---

# User Guide

## Database Overview
Entity: Album
Attributes: album_id, album_title, release_date, genre
The album_id is a unique integer ID assigned to each album, used as the primary key of the album relation. The album_title is the 155 character or less string title of the album and cannot be null. The release_date is the date time of the album's release and cannot be null. The genre is a 155 character or less string label describing the album genre and cannot be null.
Entity: artist_albums
Attributes: artist_id, album_id
The artist_id is unique integer ID assigned to each artist, used as a primary key to the artist_albums relation and foreign key to the artist relation and cannot be null. The album_id is a unique integer ID assigned to each album, used as a primary key to the artist_albums relation and foreign key to the album relation and cannot be null.
Entity: artist
Attributes: artist_id, name
The artist_id is unique integer ID assigned to each artist, used as the primary key of the artist relation. The name is a 155 character or less string name of the artist and cannot be null.
Entity: track
Attributes: title, album_id, number, length, size_bytes
The title is the 155 character or less string title of the track and cannot be null. The album_id is a unique small integer ID assigned to each album, used as a primary key to the track relation and foreign key to the album relation and cannot be null. The number is the integer track number of the track in its album. The length is the decimal length of the track playtime in minutes and cannot be null. The size_bytes is a big integer representing the size of the track in bytes.
Entity: media
Attributes: media_id, type, album_id
The media_id is a unique integer ID assigned to each media, used as a primary key in the media relation and foreign key to the checkout relation. The type is an 8 character or less string labeling the media as either "physical" or "digital" and cannot be null. The album_id is a unique integer ID assigned to each album, used as a foreign key to the album relation and cannot be null.
Entity: checkout
Attributes: checkout_id, checkout_date, return_date, media_id, card_number, due_date
The checkout_id is a unique integer ID assigned to the checkout session, used as a primary key to the checkout relation. The checkout_date is the date time at which the media was checked out, and cannot be null. The return_date is the date time at which the media was returned, and is null until returned. The media_id is a unique integer ID assigned to each media and cannot be null. The card_number is a 36 character or less string identifying the person's library card, used as a foreign key to the person relation and cannot be null. The due_date is the date time at which the media is due to be returned to the library and cannot be null.
Entity: person
Attributes: card_number, email, first_name, last_name, activation_date
The card_number is a 36 character or less string identifying the person's library card, used as a primary key in the person relation. The email is a unique 155 character or less string that is the email address of the person. The first_name is a 155 character or less string that is the first name of the person and is not null. The last_name is a 155 character or less string that is the last name of the person and is not null. The activation_date is the date time of when the person was created in the library system and is not null. 
Entity: employee
Attributes:
Entity: feedback
Attributes:
Entity: review
Attributes:

CHECK PK (underline), FK (arrow away), NULL, type


## Sample Queries

## Insertion and Deletion
