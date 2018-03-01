"""Uploads test data from `test_data.csv` into the project database."""
from math import floor
import sqlite3
import pandas as pd

# Maps to keep track of artist and albums ids on upload
album_map = {}
artist_map = {}

# Import/clean csv data
df = pd.read_csv("./test_data.csv")
df.columns = df.columns.str.strip()

# Break down data as needed
artist_albums = []
artists = list(map(lambda x: (x,), df.artist_name.unique()))
albums = df[
    ["album_title", "release_year", "genre", "artist_name"]
].drop_duplicates().values.tolist()
tracks = df[
    ["artist_name", "album_title", "track", "length_seconds"]
].values.tolist()

for i, artist in enumerate(artists):
    artist_map[artist[0]] = i + 1
for i, album in enumerate(albums):
    album_map[album[0]] = i + 1
    artist_albums.append((artist_map[album[3]], i + 1))
    albums[i] = albums[i][0:3]
for track in tracks:
    track[0] = artist_map[track[0]]
    track[1] = album_map[track[1]]
    track[3] = floor(int(track[3]) / 60. * 100) / 100

# Connect to the database
conn = sqlite3.connect("./sql.db")

# Clear existing data
print("(1/5) Clearing data...")
conn.execute("DELETE FROM album")
conn.execute("DELETE FROM artist")
conn.execute("DELETE FROM artist_albums")
conn.execute("DELETE FROM track")
conn.execute("DELETE FROM employee")
conn.execute("DELETE FROM person")
conn.execute("DELETE FROM media")
conn.execute("DELETE FROM review")
conn.execute("DELETE FROM feedback")

# Populate data
print("(2/5) Inserting artists...")
conn.executemany("INSERT INTO artist (name) VALUES (?)", artists)
print("(3/5) Inserting albums...")
conn.executemany(
    "INSERT INTO album (album_title, release_date, genre) VALUES (?, ?, ?)",
    albums
)
print("(4/5) Inserting artist albums...")
conn.executemany(
    "INSERT INTO artist_albums (artist_id, album_id) VALUES (?, ?)",
    artist_albums
)
print("(5/5) Inserting tracks...")
conn.executemany(
    "INSERT INTO track (artist_id, album_id, title, length) \
        VALUES (?, ?, ?, ?)",
    tracks
)
print("Commiting updates...")
conn.commit()
print("Done.")

# Close the db connection
conn.close()
