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