/*
 * Card number is often queried by equality to lookup information about a
 * specific user.
 */
CREATE INDEX IF NOT EXISTS person_card_numbers ON person (card_number);

/*
 * When patrons are using the system, they will most likely want to query
 * content by album name, artist name, and track name.
 */
CREATE INDEX IF NOT EXISTS album_names ON album (album_title);
CREATE INDEX IF NOT EXISTS artist_names ON artist (name);
CREATE INDEX IF NOT EXISTS track_titles ON track (title);

/*
 * Employees will likely need to query checkouts by due_date and return date,
 * in order to create reports on which media are overdue.
 */
CREATE INDEX IF NOT EXISTS checkout_due_dates ON checkout (due_date);
CREATE INDEX IF NOT EXISTS checkout_return_dates ON checkout (return_date);
