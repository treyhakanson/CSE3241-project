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

### Album

#### Insert

```sql
INSERT INTO album VALUES(1,'For Those About To Rock We Salute You',1981,'Rock');
```

#### Delete

```sql
DELETE FROM album AS a
  WHERE a.album_id = 1;
```

Must delete artist_album tuple, all tracks, all media records.

### Person

#### Insert

```sql
INSERT INTO person VALUES('18108a24-4eac-498d-a2d3-4dc4cccf405a','jasonmorris5660@gmail.com','Jason','Morris','2017-10-24 21:08:23');
```

#### Delete

```sql
DELETE FROM person AS p
  WHERE p.card_number = '18108a24-4eac-498d-a2d3-4dc4cccf405a';
```

Must delete checkout history, all feedback, all reviews, employee record if applicable.

### Artist

#### Insert

```sql
INSERT INTO artist VALUES(1,'AC/DC');
```

#### Delete

```sql
DELETE FROM artist AS a
  WHERE a.artist_id = 1;
```

Must delete artist_album tuple.

### Track

#### Insert

```sql
INSERT INTO track VALUES('Breaking The Rules',1,NULL,4.3799999999999998934,1,8596840);
```

Album must exist.

#### Delete

```sql
DELETE FROM track AS t
  WHERE t.title = 'Breaking The Rules' AND t.album_id = 1;
```

### Media

#### Insert

```sql
INSERT INTO media VALUES(1,'physical',1);
```

Album must exist.

#### Delete

```sql
DELETE FROM media AS m
  WHERE m.media_id = 1;
```

Must delete checkout history.

### Checkout

#### Insert

```sql
INSERT INTO checkout VALUES(2,'2017-08-24 03:43:51',NULL,1,'fdb627b1-23f4-4d43-8492-e5a5780d66fb','2017-12-09 13:12:44');
```

Media and person must exist.

#### Delete

```sql
DELETE FROM checkout AS c
  WHERE c.checkout_id = 2;
```

### Artist_Albums

#### Insert

```sql
INSERT INTO artist_albums VALUES(1,1);
```

Album and artist must exist.

#### Delete

```sql
DELETE FROM artist_albums AS aa
  WHERE aa.album_id = 1 AND aa.artist_id = 1;
```

### Employee

#### Insert

```sql
INSERT INTO employee VALUES('2017-10-29 12:55:42',51055.999999999999998,'librarian','18108a24-4eac-498d-a2d3-4dc4cccf405a');
```

Person must exist.

#### Delete

```sql
DELETE FROM employee AS e
  WHERE e.card_number = '18108a24-4eac-498d-a2d3-4dc4cccf405a';
```

### Feedback

#### Insert

```sql
INSERT INTO feedback VALUES(1,replace('Ok among class too. Fund organization throughout too when. Media green certain line.\nWest value campaign personal address recent already. Meeting worker ball east leave or.','\n',char(10)),'2017-08-31 14:12:30','books','5bdb012a-f823-4c8b-83e8-60c36c61743b');
```

Person must exist.

#### Delete

```sql
DELETE FROM feedback AS f
  WHERE f.feedback_id = 1;
```

### Review

#### Insert

```sql
INSERT INTO review VALUES(1,0,replace('Outside hard discuss subject wind dark simply. Market big specific enter upon left sea.\nWatch that everyone mouth wrong. Play community agent particularly e','\n',char(10)),replace('Marriage minute again rather nice design unit. Area would scientist focus.\nFrom best experience our paper quite value. Sea yourself cause environmental account he.','\n',char(10)),57,'284388ff-f6d6-417e-b8de-be17cd8c909c');
```

Person must exist.

#### Delete

```sql
DELETE FROM review AS r
  WHERE r.review_id = 1;
```
