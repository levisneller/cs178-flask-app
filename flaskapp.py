# Original template authors: T. Urness and M. Moore
# description: Flask example using redirect, url_for, and flash
# credit: the template html files were constructed with the help of ChatGPT
# New Author: Levi Sneller

from flask import Flask
from flask import render_template
from flask import Flask, render_template, request, redirect, url_for, flash
from dbCode import *

app = Flask(__name__)
app.secret_key = 'your_secret_key' # this is an artifact for using flash displays; 
                                   # it is required, but you can leave this alone

@app.route('/')
def home():
    return render_template('home.html')

# add movie code
# Claude assisted in debugging my initial version
@app.route('/add-movie', methods=['GET', 'POST'])
def add_movie_route():
    directors = get_all_directors()
    studios = get_all_studios()
    if request.method == 'POST':
        # Extract form data
        title = request.form['title']
        year = request.form['year']
        genre = request.form['genre']
        director_id = request.form['director_id']
        studio_id = request.form['studio_id']
        
        # Add movie to the database
        success = add_movie(title, year, genre, director_id, studio_id)
        
        if success:
            flash(f'"{title}" added successfully!', 'success')
        else:
            flash('Failed to add movie.', 'error')
        
        # Redirect to display movies page
        return redirect(url_for('home'))
    else:
        # Render the form page if the request method is GET
        return render_template('add_movie.html', directors=directors, studios=studios)

# Code to delete a movie (based on original code and flash code above)
@app.route('/delete-movie',methods=['GET', 'POST'])
def delete_movie_route():
    if request.method == 'POST':
        # Extract form data
        title = request.form['title']
        success = delete_movie(title)
        if success:
            flash('Movie deleted successfully!', 'warning')
        else:
            flash('Failed to delete movie.', 'error')
        return redirect(url_for('home'))
    else:
        # Render the form page if the request method is GET
        return render_template('delete_movie.html')

@app.route('/display-movies')
def browse():
    # Calude was used to help implement try/except to handle errors
    try:
        movies = get_all_movies()
    except Exception as e:
        flash(f'Error loading movies: {e}', 'error')
        movies = []
    return render_template('display_movies.html', movies=movies)


# these two lines of code should always be the last in the file
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)
