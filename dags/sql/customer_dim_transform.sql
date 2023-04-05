TRUNCATE TABLE customer_dim;

INSERT INTO customer_dim(customer_id, first_name, last_name, email, address, address2, district, city, country, postal_code, create_date, start_date, end_date)

SELECT c.customer_id,
       c.first_name,
       c.last_name,
       c.email,
       a.address,
       a.address2,
       a.district,
       ci.city,
       co.country,
       a.postal_code,
       c.create_date,
       GETDATE() AS start_date,
       GETDATE() AS end_date
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;