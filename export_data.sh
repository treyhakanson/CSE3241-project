#! /bin/bash
rm -rf data
mkdir data
for table in "album" "person" "artist" "track" "media" "checkout" "artist_albums" "employee" "feedback" "review"
do
   sqlite3 -csv ./sql.db "SELECT * FROM $table;" > "data/$table.csv"
done
