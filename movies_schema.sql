-- ============================================================
-- CS178 Project 1 — Movies Database Schema
-- Author: Levi Sneller
-- Description: Three-table schema: Directors, Studios, and Movies.
--              Designed for full CRUD operations and JOIN queries.
--              Movies JOIN Directors: show movies with director name.
--              Movies JOIN Studios: show movies with studio name.
-- ============================================================

-- Drop tables in correct order (Movies first due to foreign keys)
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS Directors;
DROP TABLE IF EXISTS Studios;

-- ============================================================
-- Table 1: Directors (39 total)
-- ============================================================
CREATE TABLE Directors (
    DirectorID   INT AUTO_INCREMENT PRIMARY KEY,
    FirstName    VARCHAR(50)  NOT NULL,
    LastName     VARCHAR(50)  NOT NULL,
    Nationality  VARCHAR(50)
);

-- ============================================================
-- Table 2: Studios (14 total)
-- ============================================================
CREATE TABLE Studios (
    StudioID   INT AUTO_INCREMENT PRIMARY KEY,
    StudioName VARCHAR(100) NOT NULL,
    Country    VARCHAR(50)
);

-- ============================================================
-- Table 3: Movies (57 total)
-- ============================================================
CREATE TABLE Movies (
    MovieID     INT AUTO_INCREMENT PRIMARY KEY,
    Title       VARCHAR(100) NOT NULL,
    ReleaseYear INT,
    Genre       VARCHAR(50),
    DirectorID  INT,
    StudioID    INT,
    FOREIGN KEY (DirectorID) REFERENCES Directors(DirectorID),
    FOREIGN KEY (StudioID)   REFERENCES Studios(StudioID)
);

-- ============================================================
-- INSERT: Directors
-- ============================================================
INSERT INTO Directors (FirstName, LastName, Nationality) VALUES
('Christopher',     'Nolan',        'British-American'),    -- 1
('Denis',           'Villeneuve',   'Canadian'),            -- 2
('Chad',            'Stahelski',    'American'),            -- 3
('Frank',           'Darabont',     'American'),            -- 4
('Sam',             'Mendes',       'British'),             -- 5
('Matt',            'Reeves',       'American'),            -- 6
('Brian',           'De Palma',     'American'),            -- 7
('David',           'Leitch',       'American'),            -- 8
('Martin',          'Scorsese',     'American'),            -- 9
('David',           'Fincher',      'American'),            -- 10
('Peter',           'Jackson',      'New Zealander'),       -- 11
('Ridley',          'Scott',        'British'),             -- 12
('Steven',          'Spielberg',    'American'),            -- 13
('Antoine',         'Fuqua',        'American'),            -- 14
('James',           'Mangold',      'American'),            -- 15
('Francis Ford',    'Coppola',      'American'),            -- 16
('Taylor',          'Sheridan',     'American'),            -- 17
('Nicolas Winding', 'Refn',         'Danish'),              -- 18
('Roman',           'Polanski',     'French-Polish'),       -- 19
('Robert',          'Zemeckis',     'American'),            -- 20
('Gus',             'Van Sant',     'American'),            -- 21
('Ryan',            'Coogler',      'American'),            -- 22
('Adam',            'McKay',        'American'),            -- 23
('Guy',             'Ritchie',      'British'),             -- 24
('Michael',         'Mann',         'American'),            -- 25
('Damien',          'Chazelle',     'American'),            -- 26
('Sean',            'Durkin',       'American'),            -- 27
('Martin',          'Campbell',     'British-New Zealander'), -- 28
('John G.',         'Avildsen',     'American'),            -- 29
('Steven',          'Soderbergh',   'American'),            -- 30
('Ilya',            'Naishuller',   'Russian'),             -- 31
('Gavin',           'O''Connor',    'American'),            -- 32
('David',           'Ayer',         'American'),            -- 33
('James',           'Gunn',         'American'),            -- 34
('Todd',            'Phillips',     'American'),            -- 35
('Christian',       'Gudegast',     'American'),            -- 36
('J.C.',            'Chandor',      'American'),            -- 37
('Shane',           'Black',        'American'),            -- 38
('Brad',            'Bird',         'American');            -- 39

-- ============================================================
-- INSERT: Studios
-- ============================================================
INSERT INTO Studios (StudioName, Country) VALUES
('Warner Bros.',            'USA'),    -- 1
('Columbia Pictures',       'USA'),    -- 2
('Lionsgate',               'USA'),    -- 3
('MGM',                     'USA'),    -- 4
('Universal Pictures',      'USA'),    -- 5
('Paramount Pictures',      'USA'),    -- 6
('20th Century Studios',    'USA'),    -- 7
('New Line Cinema',         'USA'),    -- 8
('DreamWorks Pictures',     'USA'),    -- 9
('Miramax',                 'USA'),    -- 10
('A24',                     'USA'),    -- 11
('Netflix',                 'USA'),    -- 12
('Marvel Studios',          'USA'),    -- 13
('Walt Disney Pictures',    'USA');    -- 14

-- ============================================================
-- INSERT: Movies
-- ============================================================
INSERT INTO Movies (Title, ReleaseYear, Genre, DirectorID, StudioID) VALUES

-- Christopher Nolan
('Batman Begins',                                       2005, 'Action',       1,  1),   -- Warner Bros.
('The Dark Knight',                                     2008, 'Action',       1,  1),   -- Warner Bros.
('Inception',                                           2010, 'Sci-Fi',       1,  1),   -- Warner Bros.
('Interstellar',                                        2014, 'Sci-Fi',       1,  1),   -- Warner Bros.
('Dunkirk',                                             2017, 'War',          1,  1),   -- Warner Bros.
('Oppenheimer',                                         2023, 'Biography',    1,  5),   -- Universal Pictures

-- Denis Villeneuve
('Prisoners',                                           2013, 'Mystery',      2,  1),   -- Warner Bros.
('Sicario',                                             2015, 'Thriller',     2,  3),   -- Lionsgate
('Blade Runner 2049',                                   2017, 'Sci-Fi',       2,  1),   -- Warner Bros.
('Dune',                                                2021, 'Sci-Fi',       2,  1),   -- Warner Bros.

-- Chad Stahelski
('John Wick',                                           2014, 'Action',       3,  3),   -- Lionsgate

-- Frank Darabont
('The Shawshank Redemption',                            1994, 'Drama',        4,  2),   -- Columbia Pictures

-- Sam Mendes
('Skyfall',                                             2012, 'Action',       5,  2),   -- Columbia Pictures
('1917',                                                2019, 'War',          5,  5),   -- Universal Pictures

-- Matt Reeves
('The Batman',                                          2022, 'Action',       6,  1),   -- Warner Bros.

-- Brian De Palma
('Scarface',                                            1983, 'Crime',        7,  5),   -- Universal Pictures
('Mission: Impossible',                                 1996, 'Action',       7,  6),   -- Paramount Pictures

-- David Leitch
('Bullet Train',                                        2022, 'Action',       8,  2),   -- Columbia Pictures

-- Martin Scorsese
('Goodfellas',                                          1990, 'Crime',        9,  1),   -- Warner Bros.
('Casino',                                              1995, 'Crime',        9,  5),   -- Universal Pictures
('The Departed',                                        2006, 'Crime',        9,  1),   -- Warner Bros.
('The Wolf of Wall Street',                             2013, 'Crime',        9,  6),   -- Paramount Pictures

-- David Fincher
('Seven',                                               1995, 'Mystery',      10, 8),   -- New Line Cinema
('Fight Club',                                          1999, 'Drama',        10, 7),   -- 20th Century Studios
('The Social Network',                                  2010, 'Drama',        10, 2),   -- Columbia Pictures

-- Peter Jackson
('The Lord of the Rings: The Fellowship of the Ring',   2001, 'Fantasy',      11, 8),   -- New Line Cinema

-- Ridley Scott
('Gladiator',                                           2000, 'Action',       12, 9),   -- DreamWorks Pictures
('The Martian',                                         2015, 'Sci-Fi',       12, 7),   -- 20th Century Studios

-- Steven Spielberg
('Saving Private Ryan',                                 1998, 'War',          13, 9),   -- DreamWorks Pictures
('Catch Me If You Can',                                 2002, 'Biography',    13, 9),   -- DreamWorks Pictures

-- Antoine Fuqua
('The Equalizer',                                       2014, 'Action',       14, 2),   -- Columbia Pictures

-- James Mangold
('Logan',                                               2017, 'Action',       15, 7),   -- 20th Century Studios
('Ford v Ferrari',                                      2019, 'Drama',        15, 7),   -- 20th Century Studios

-- Francis Ford Coppola
('The Godfather',                                       1972, 'Crime',        16, 6),   -- Paramount Pictures

-- Taylor Sheridan
('Wind River',                                          2017, 'Mystery',      17, 3),   -- Lionsgate

-- Nicolas Winding Refn
('Drive',                                               2011, 'Action',       18, 5),   -- Universal Pictures

-- Roman Polanski
('The Pianist',                                         2002, 'Drama',        19, 5),   -- Universal Pictures

-- Robert Zemeckis
('Forrest Gump',                                        1994, 'Drama',        20, 6),   -- Paramount Pictures

-- Gus Van Sant
('Good Will Hunting',                                   1997, 'Drama',        21, 10),  -- Miramax

-- Ryan Coogler
('Creed',                                               2015, 'Drama',        22, 4),   -- MGM

-- Adam McKay
('The Big Short',                                       2015, 'Biography',    23, 6),   -- Paramount Pictures

-- Guy Ritchie
('The Gentlemen',                                       2019, 'Crime',        24, 10),  -- Miramax

-- Michael Mann
('Heat',                                                1995, 'Crime',        25, 1),   -- Warner Bros.

-- Damien Chazelle
('Whiplash',                                            2014, 'Drama',        26, 2),   -- Columbia Pictures

-- Sean Durkin
('The Iron Claw',                                       2023, 'Drama',        27, 11),  -- A24

-- Martin Campbell
('Casino Royale',                                       2006, 'Action',       28, 2),   -- Columbia Pictures

-- John G. Avildsen
('Rocky',                                               1976, 'Drama',        29, 4),   -- MGM

-- Steven Soderbergh
('Ocean''s Eleven',                                     2001, 'Crime',        30, 1),   -- Warner Bros.

-- Ilya Naishuller
('Nobody',                                              2021, 'Action',       31, 5),   -- Universal Pictures

-- Gavin O'Connor
('The Accountant',                                      2016, 'Action',       32, 1),   -- Warner Bros.

-- David Ayer
('Fury',                                                2014, 'War',          33, 2),   -- Columbia Pictures

-- James Gunn
('Guardians of the Galaxy',                             2014, 'Action',       34, 13),  -- Marvel Studios

-- Todd Phillips
('War Dogs',                                            2016, 'Biography',    35, 1),   -- Warner Bros.

-- Christian Gudegast
('Den of Thieves',                                      2018, 'Crime',        36, 3),   -- Lionsgate

-- J.C. Chandor
('Triple Frontier',                                     2019, 'Action',       37, 12),  -- Netflix

-- Shane Black
('The Nice Guys',                                       2016, 'Crime',        38, 1),   -- Warner Bros.

-- Brad Bird
('Ratatouille',                                         2007, 'Animation',    39, 14);  -- Walt Disney Pictures
