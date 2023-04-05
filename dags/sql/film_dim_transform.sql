TRUNCATE TABLE film_dim;

INSERT INTO film_dim (film_id, title, description, release_year, language, rental_duration, length, rating, special_features)
SELECT 
    f.film_id, 
    f.title, 
    f.description, 
    f.release_year, 
    l.name as language, 
    f.rental_duration, 
    f.length, 
    f.rating, 
    f.special_features 
FROM 
    film f
    JOIN language l ON f.language_id = l.language_id;
