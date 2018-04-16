#! /bin/bash
sqlite3 $1 < init_tables.sql
sqlite3 $1 < upload_data.sql
