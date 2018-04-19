#! /bin/bash
# Generate CSVs
rm -rf data
mkdir data
for table in "album" "person" "artist" "track" "media" "checkout" "artist_albums" "employee" "feedback" "review"
do
   sqlite3 -csv ./sql.db "SELECT * FROM $table;" > "data/$table.csv"
done

# Generate dump
sqlite3 sql.db .schema > windows/schema.sql
sqlite3 sql.db .dump > windows/dump.sql
grep -vx -f windows/schema.sql windows/dump.sql > windows/data.sql
