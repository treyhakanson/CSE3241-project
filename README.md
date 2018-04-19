Maggie Baumgardner, Sruti Chigurupati, Trey Hakanson, Elizabeth Gilbert

CSE 3421

04/20/2018

Final Project README

---

# CSE 3421 Final Project

## Database Recovery

If the `sql.db` file gets corrupted, the SQL in the following file can be executed to create a new instance of the database:

```
sql/dumb.sql
```

This is a SQL file, not a database file, and can be opened from any text editor.

## User Guide

The user guide is in a separate file from this README, and can be found in:

```
UserGuide.pdf
```

## Transactions, Indexes, Views, and Other SQL

All SQL scripts can be found in the `sql` directory, including annotations.

## Additional Information

The following diagrams can be found in the `diagrams` directory:

* EERD
* Relational Schema

Additional, here are all of the functional dependencies present in the relational schema:

### ALBUM

> { album_id } -> { album_title, release_date, genre }

### ARTIST_ALBUMS

> { album_id, artist_id } -> { album_id, artist_id }

### ARTIST

> { artist_id } -> { name }

### TRACK

> { album_id, title } -> { number, length, artist_id }

### MEDIA

> { media_id } -> { type, album_id }

### CHECKOUT

> { checkout_id } -> { checkout_date, media_id, return_date, card_number }

### PERSON

> { card_number } -> { activation_date, first_name, last_name }

### EMPLOYEE

> { card_number } -> { position, salary, start_date }

### FEEDBACK

> { feedback_id } -> { description, date, category, card_number }

### REVIEW

> { review_id } -> { stars, title, card_number, album_id, description }
