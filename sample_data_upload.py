"""Uploads sample data into tables we were not given test data for."""
from uuid import uuid4
from faker import Faker
import random
import sqlite3

# Create faker object
fake = Faker()

# Create database connection
conn = sqlite3.connect("./sql.db")

# Pull the albums
c = conn.cursor()
c.execute("SELECT album_id FROM album")
album_ids = list(map(lambda x: x[0], c.fetchall()))

# Create data for `person` table
print("(1/5) Creating people...")
people = []
for i in range(100):
    card_number = str(uuid4())
    first, last, *_ = fake.name().split(" ")
    activation_date = fake.past_datetime(start_date="-1y", tzinfo=None)
    people.append((card_number, first, last, activation_date))
conn.executemany("INSERT INTO person VALUES (?, ?, ?, ?)", people)

# Create `employee` data using a portion of the people previously created
print("(2/5) Creating Employees...")
titles = ["librarian", "janitor", "intern", "manager"]
employees = []
for person in people[:21]:
    start_date = fake.past_datetime(start_date=person[3], tzinfo=None)
    salary = random.randrange(40e3, 80e3)
    position = random.choice(titles)
    card_number = person[0]
    employees.append((start_date, salary, position, card_number))
conn.executemany("INSERT INTO employee VALUES (?, ?, ?, ?)", employees)

# Create feedback for a portion of non-employees
print("(3/5) Creating feedback...")
categories = ["music", "books", "staff", "facilities"]
feedbacks = []
for person in people[21:41]:
    description = fake.text()[:501]
    date = fake.past_datetime(start_date=person[3], tzinfo=None)
    category = random.choice(categories)
    card_number = person[0]
    feedbacks.append((description, date, category, card_number))
conn.executemany(
    "INSERT INTO feedback (description, date, category, card_number) \
        VALUES (?, ?, ?, ?)",
    feedbacks
)

# Create reviews for a portion of non-employees
print("(4/5) Creating reviews...")
reviews = []
for person in people[41:61]:
    stars = random.randint(0, 5)
    title = fake.text()[:156]
    description = fake.text()[:501]
    album_id = random.choice(album_ids)
    card_number = person[0]
    reviews.append((stars, title, description, album_id, card_number))
conn.executemany(
    "INSERT INTO review (stars, title, description, album_id, card_number) \
        VALUES (?, ?, ?, ?, ?)",
    reviews
)

# Create 1 physical or digital media for every album
print("(5/5) Creating media...")
media_type = ["physical", "digital"]
media = []
for album_id in album_ids:
    media_type = random.choice(media_type)
    card_number = None
    checkout_date = None
    if random.randint(0, 1) is 1:
        owner = random.choice(people)
        card_number = owner[0]
        checkout_date = fake.past_datetime(start_date=person[3], tzinfo=None)
    media.append((media_type, checkout_date, album_id, card_number))
conn.executemany(
    "INSERT INTO media (type, checkout_date, album_id, card_number) \
        VALUES (?, ?, ?, ?)",
    media
)

print("Commiting updates...")
conn.commit()

# Close the db connection
conn.close()
print("Done.")
