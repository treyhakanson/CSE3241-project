Maddie Baumgardner, Sruti Chigurupati, Trey Hakanson, Elizabeth Gilbert
CSE 3421
04/20/2018
Final Project User Guide

---

# User Guide

## Database Overview

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
