Maddie Baumgardner, Sruti Chigurupati, Trey Hakanson, Elizabeth Gilbert
CSE 3421
04/20/2018
Final Project User Guide

---

# User Guide

```sql
SELECT * FROM table;
```

## Database Overview

## Sample Queries
### Relation Algebra Queries from Checkpoint 2
a.  Find the titles of all songs by ARTIST released before YEAR

    πtrack_title(σrelease_date < YEAR (σname = ARTIST ARTIST*ARTIST_ALBUMS*ALBUM*TRACK))

b.  Give all the albums and their date of their checkout from a single patron (you choose how to designate the patron)

    πalbum_title, checkout_dateσcard_number = CARD NUMBER(PERSON*MEDIA*ALBUM)

c.  List all the albums and their unique identifiers with less than 5 copies held by the library.

    πalbum_id, title(σcount < 5(album_idFCOUNT album_id(ALBUM*MEDIA)))

d.  Give all the patrons who checked out an album by ARTIST and the albums they checked out.

    πfirst_name, last_name, album_title(σcheckout_date != NULL(σname = ARTIST ARTIST*ARTIST_ALBUMS*ALBUM*PERSON*MEDIA))

e.  Find the total number of albums checked out by a single patron (you choose how to designate the patron)

    FCOUNT album_id(σcard_number = CARD NUMBERMEDIA)

f.  Find the patron who has checked out the most albums and the total number of albums they have checked out.

    FMAX count(card_numberFCOUNT album_id(σcheckout_date != NULLMEDIA))

### Additional Relational Algebra Queries from Checkpoint 2
a.  Number of feedbacks each patron as given

    card_numberFCOUNT  feedback_id(PERSON*FEEDBACK)

b.  Average star rating for each album

    albumFAVERAGE stars(REVIEW*ALBUM)

c.  How many copies does each album have (physical and digital)?

    album_idFCOUNT media_id(ALBUM*MEDIA)

### Queries from Checkpoint 3
a.  Find the titles of all tracks by ARTIST released before YEAR
```sql
SELECT t.title
    FROM track t
        JOIN album a ON a.album_id = t.album_id
        JOIN artist_albums aa ON aa.album_id = a.album_id
        JOIN artist art ON art.artist_id = aa.artist_id
    WHERE name = 'AC/DC' AND
          release_date < 1982;
```

b.  Give all the albums and their date of their checkout from a single patron (you choose how to designate the patron)
```sql
SELECT album_title, release_date
   FROM Album AS a
   	JOIN media AS m ON a.album_id = m.album_id
      JOIN checkout AS c ON m.media_id = c.media_id
   	JOIN person AS p ON p.card_number = c.card_number
   WHERE p.card_number = '7eddeba0-c2cc-4d7a-a1b1-7248c9dbda63';
```

c.  List all the albums and their unique identifiers with less than 5 copies held by the library.
```sql
SELECT a.album_id, a.album_title
    FROM album a
        JOIN media m ON a.album_id = m.album_id
    GROUP BY a.album_id
    HAVING COUNT(*) < 5;
```

d.  Give all the patrons who checked out an album by ARTIST and the albums they checked out.
```sql
SELECT album_title, first_name, last_name
   FROM Album AS a
   	JOIN Media AS m ON a.album_id = m.album_id
      JOIN checkout AS c ON m.media_id = c.media_id
   	JOIN Person AS p ON p.card_number = c.card_number
   	JOIN Artist_Albums aa ON a.album_id = aa.album_id
   	JOIN Artist a2 ON aa.artist_id = a2.artist_id
   WHERE a2.name = "AC/DC";
```

e.  Find the total number of albums checked out by a single patron (you choose how to designate the patron)
```sql
SELECT COUNT(*)
    FROM media AS m
        JOIN checkout AS c ON m.media_id = c.media_id
        JOIN person AS p ON p.card_number = c.card_number
        WHERE p.card_number = '7eddeba0-c2cc-4d7a-a1b1-7248c9dbda63';
```

f.  Find the patron who has checked out the most albums and the total number of albums they have checked out.
```sql
SELECT full_name, MAX(count)
    FROM (
        SELECT first_name || ' ' || last_name full_name, COUNT(*) count
            FROM media m
                JOIN checkout AS c ON m.media_id = c.media_id
                JOIN person p ON p.card_number = c.card_number
            GROUP BY p.card_number
            ORDER BY COUNT(*) DESC
    );
```

### Additional Queries from Checkpoint 3
a. Number of feedbacks each patron as given
```sql
SELECT first_name || ' ' || last_name, COUNT(*)
    FROM person p
        JOIN feedback f ON p.card_number = f.card_number
    GROUP BY p.card_number;
```

b.  Average star rating for each album
```sql
SELECT album_title, AVG(stars)
   FROM review r
      JOIN album a ON a.album_id = r.album_id
   GROUP BY a.album_id;
```

c.  How many copies does each album have (physical and digital)?
```sql
SELECT a.album_title, COUNT(*)
    FROM album a
        JOIN media m ON a.album_id = m.album_id
    GROUP BY a.album_id;
```

### Queries from Checkpoint 4
a. Provide a list of patron names, along with the total combined running time of all the albums they have checked out.
```sql
SELECT full_name, SUM(length)
    FROM (
        SELECT first_name || ' ' || last_name full_name, p.card_number card_number, m.album_id media_album_id
            FROM media m
                JOIN checkout c ON c.media_id = m.media_id
                JOIN person p ON p.card_number = c.card_number
    ) JOIN track t on media_album_id = t.album_id
    GROUP BY card_number;
```

b. Provide a list of patron names and email addresses for patrons who have checked out more albums than the average patron.
```sql
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
```

c. Provide a list of the albums in the database and associated total copies lent to patrons, sorted from the album that has been lent the most to the album that has been lent the least.
```sql
SELECT album_title, COUNT(*)
    FROM album a
        JOIN media m ON a.album_id = m.album_id
        JOIN checkout c ON c.media_id = m.media_id
    WHERE return_date IS NULL
    GROUP BY album_title
    ORDER BY COUNT(*) DESC;
```
d. Provide a list of the titles in the database and associated totals for copies checked out to customers, sorted from the title that has been checked out the highest amount to the title checked out the smallest.
```sql
SELECT a.album_title, COUNT(*)
	FROM album a
    	JOIN media m ON a.album_id = m.album_id
        JOIN checkout c ON m.media_id = c.media_id
    GROUP BY a.album_title
    ORDER BY COUNT(*) DESC;
```
e. Find the most popular artist in the database (i.e. the one who has had the most lent albums)
```sql
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
```
f. Find the most listened to artist in the database (use the running time of the album and number of times the album has been lent out to calculate)
```sql
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
```
g. Provide a list of customer information for patrons who have checked out anything by the most listened to artist in the database.
```sql
SELECT p.card_number, email, first_name || ' ' || last_name full_name
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
```
h. Provide a list of artists who authored the albums checked out by customers who have checked out more albums than the average customer.
```sql
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
    );
```




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
