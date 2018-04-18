# CSE 3421 Project

## Database Recovery

If the `sql.db` file gets corrupted, but generating new data is not desired, run the following to create the required tables and upload the data in the `data` directory (Unix systems only):

```sh
bash init_new_database.sh <database_name>
```

Where `<database_name>` is the desired name of the resultant database.

If you're on windows, you can run the sql in the file `windows/data.sql`.

## Database Generation

Scripts to create a new database, and populate it with sample data.

Requirements:

1. Python 3
2. Sqlite3 (on mac if you have [homebrew](http://brew.sh), just run `brew install sql3`)

To start, install requirements:

```sh
pip3 -r install requirements.txt
```

Then run the upload script:

```sh
python3 test_data_upload.py
```
