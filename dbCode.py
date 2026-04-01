# dbCode.py
# Author: Levi Sneller
# Helper functions for database connection and queries

import pymysql
import creds

def get_conn():
    """Returns a connection to the MySQL RDS instance."""
    conn = pymysql.connect(
        host=creds.host,
        user=creds.user,
        password=creds.password,
        db=creds.db,
    )
    return conn

def execute_query(query, args=()):
    """Executes a SELECT query and returns all rows as dictionaries."""
    cur = get_conn().cursor(pymysql.cursors.DictCursor)
    cur.execute(query, args)
    rows = cur.fetchall()
    cur.close()
    return rows

# Function to execute updata (used in add_movie)
# Claude assisted in generating this code
def execute_update(query, args=()):
    """Executes INSERT, UPDATE, or DELETE queries."""
    try:
        conn = get_conn()
        cur = conn.cursor()
        cur.execute(query, args)
        conn.commit()
        cur.close()
        conn.close()
        return True
    except Exception as e:
        print(f"[DB ERROR - execute_update]: {e}")
        return False

# Claude helped debug my initial attempt at writing this code
def get_all_movies():
    #Gets information for all movies, uses join for direector and studio
    query = """
        SELECT m.Title, m.ReleaseYear, m.Genre, 
            CONCAT(d.FirstName, ' ', d.LastName) AS Director,
            s.StudioName
        FROM Movies m
        JOIN Directors d on m.DirectorID = d.DirectorID
        JOIN Studios s ON m.StudioID = s.StudioID
        ORDER BY m.ReleaseYear DESC
    """
    return execute_query(query)

# Function to get all directors (used for dropdown to add a movie)
def get_all_directors():
    query = """
        SELECT DirectorID, CONCAT(FirstName, ' ', LastName) AS Director
        FROM  Directors
        ORDER BY LastName
    """
    return execute_query(query)

# Function to get all studios (used for dropdown to add a movie)
def get_all_studios():
    query = """
        SELECT StudioID, StudioName
        FROM  Studios
        ORDER BY StudioName
    """
    return execute_query(query)

# Function to add a new movie
# Claude assisted in generating this code (and debugging my first version)
def add_movie(title, year, genre, director_id, studio_id):
    """Insert a new movie into the Movies table."""
    return execute_update("""
        INSERT INTO Movies (Title, ReleaseYear, Genre, DirectorID, StudioID)
        VALUES (%s, %s, %s, %s, %s)
    """, (title, year, genre, director_id, studio_id))

