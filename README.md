# Film Database Project

**CS178: Cloud and Database Systems — Project #1**
**Author:** Levi Sneller
**GitHub:** levisneller

---

## Overview

For this project, I created a custom web-based film database. I used AWS RDS (MySQL) to implement a relational database with full CRUD functionality, allowing users to view, add, delete, and update films. I also used AWS DynamoDB to create a separate non-relational database for movie ratings, allowing users to rate films and view average ratings across the collection. Both databases are integrated into a single web application hosted on AWS EC2 using Flask.

---

## Technologies Used

- **Flask** — Python web framework
- **AWS EC2** — hosts the running Flask application
- **AWS RDS (MySQL)** — relational database for storing films, directors, and studios
- **AWS DynamoDB** — non-relational database for storing user-submitted movie ratings
- **GitHub Actions** — auto-deploys code from GitHub to EC2 on push

---

## Project Structure

```
cs178-flask-app/
├── flaskapp.py               # Main Flask application — routes and app logic
├── dbCode.py                 # MySQL/RDS helper functions (connection + queries)
├── dynamoCode.py             # DynamoDB helper functions for movie ratings
├── creds.py                  # Credentials file — NOT committed to GitHub
├── movies_schema.sql         # SQL schema for Movies, Directors, and Studios tables
├── templates/
│   ├── home.html             # Landing page with navigation buttons
│   ├── display_movies.html   # Displays all films from RDS using JOIN query
│   ├── add_movie.html        # Form to add a new film to RDS
│   ├── delete_movie.html     # Form to delete a film from RDS by title
│   ├── update_movie.html     # Two-step form to look up and update a film in RDS
│   ├── get_ratings.html      # Displays all movie ratings from DynamoDB
│   ├── add_ratings.html      # Form to submit a movie rating to DynamoDB
├── .gitignore                # Excludes creds.py and other sensitive files
└── README.md                 # Project description
```

---

## How to Run Locally

1. Clone the repository:

   ```bash
   git clone https://github.com/levisneller/cs178-flask-app.git
   cd cs178-flask-app
   ```

2. Install dependencies:

   ```bash
   pip3 install flask pymysql boto3
   ```

3. Set up your credentials (see Credential Setup below)

4. Run the app:

   ```bash
   python3 flaskapp.py
   ```

5. Open your browser and go to `http://127.0.0.1:8080`

---

## How to Access in the Cloud

The app is deployed on an AWS EC2 instance. To view the live version:

```
http://18.207.151.230:8080/
```

_(Note: the EC2 instance may not be running after project submission.)_

---

## Credential Setup

This project requires a `creds.py` file that is **not included in this repository** for security reasons.

Create a file called `creds.py` in the project root with the following format:

```python
# creds.py — do not commit this file
host = "your-rds-endpoint"
user = "admin"
password = "your-password"
db = "MoviesDB"
```

---

## Database Design

### SQL (MySQL on RDS)

My relational database contains 3 tables: Movies, Directors, and Studios. The Movies table contains the following columns: MovieID (PK), Title, ReleaseYear, Genre, DirectorID (FK), and StudioID (FK). The Studios table contains: StudioID (PK), StudioName, and Country. The Directors table contains: DirectorID (PK), FirstName, LastName, and Nationality. Directors and Studios connect to the Movies table via foreign keys.

- `Movies` — stores film data; primary key is `MovieID`; foreign keys `DirectorID` and `StudioID` link to Directors and Studios tables
- `Directors` — stores director information; primary key is `DirectorID`
- `Studios` — stores studio information; primary key is `StudioID`

**JOIN query used in this project:**

The `get_all_movies()` function in `dbCode.py` joins all three tables to display each film alongside its director's full name and studio:
```sql
SELECT m.Title, m.ReleaseYear, m.Genre,
       CONCAT(d.FirstName, ' ', d.LastName) AS Director,
       s.StudioName
FROM Movies m
JOIN Directors d ON m.DirectorID = d.DirectorID
JOIN Studios s ON m.StudioID = s.StudioID
ORDER BY m.ReleaseYear DESC
```

### DynamoDB

- **Table name:** `Movies`
- **Partition key:** `Title` (String)
- **Used for:** Storing user submitted movie ratings as a list of numbers (0-100 scale)
- Each item contains a `Title` and a `Ratings` list; the average rating is calculated each time the ratings page is loaded
- This database is separate from the MySQL RDS database but is accessed from the same Flask web application

---

## CRUD Operations

Full CRUD operations are implemented using the MySQL RDS database:

| Operation | Route | Description |
| --------- | ----- | ----------- |
| Create | `/add-movie` | Adds a new film to the MySQL database with title, year, genre, director, and studio |
| Read | `/display-movies` | Displays all films from the MySQL database using a JOIN query across three tables |
| Update | `/update-movie` | Looks up a film by title and allows editing of all fields |
| Delete | `/delete-movie` | Removes a film from the MySQL database by title |

The dynamoDB database also implements two of the four CRUD operations:

| Operation | Route | Description |
| --------- | ----- | ----------- |
| Create | `/rate-movie` | Adds a new rating to a movie in DynamoDB; creates the movie entry if it doesn't exist |
| Read | `/view-ratings` | Displays all rated movies and their average ratings from DynamoDB |

---

## Challenges and Insights

The hardest part of this project was integrating the different software components together, including Visual Studio Code, GitHub, Flask, AWS EC2, AWS RDS, and AWS DynamoDB. I initially encountered issues connecting these components, ultimately determining the cause was a misconfigured deploy.yml file and an incorrect AWS RDS-to-EC2 security group connection. After resolving these issues, the remaining development was mostly straightforward, though it still required significant time and debugging to work through all of the code. I utilized Claude to assist with this process (as described below). Overall, I found this project interesting and learned that web development is more complicated than it often appears. One notable design decision was using dropdown menus to select directors and studios when adding or updating films, which simplified the interface while keeping the current database structure and relationships intact.

---

## AI Assistance

Claude was used to assist with this project. While I made an attempt to write all code independently, Claude was used to help debug and refine my initial attempts. It was particularly useful for formatting HTML files and this README, since I am new to both. All instances where Claude was used are explicitly noted in comments throughout the Python files.
