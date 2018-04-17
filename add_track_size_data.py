import sqlite3
import pandas as pd

conn = sqlite3.connect("./sql.db")

# load all tracks (from db)
c = conn.cursor()
c.execute("SELECT * FROM track")
tracks = c.fetchall()

# load all tracks (from csv)
df = pd.read_csv("./test_data.csv")
df.columns = df.columns.str.strip()
new_tracks = []

for track in tracks:
    size_bytes = int(df.loc[df["track"] == track[0]]['size_bytes'].values[0])
    new_track = list(track)
    new_track[len(track) - 1] = size_bytes
    new_tracks.append(new_track)

df2 = pd.DataFrame(new_tracks)
df2.to_csv("new_track_data.csv")

conn.execute("DELETE FROM track")
conn.executemany("""
    INSERT INTO track (title, album_id, number, length, artist_id, size_bytes)
        VALUES (?, ?, ?, ?, ?, ?)
    """,
    new_tracks)
conn.commit()
