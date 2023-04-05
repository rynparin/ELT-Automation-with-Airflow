TRUNCATE TABLE store_dim;

INSERT INTO store_dim (
    store_id,
    address,
    address2,
    district,
    city,
    country,
    postal_code,
    manager_first_name,
    manager_last_name,
    start_date,
    end_date
)
SELECT
    s.store_id,
    a.address,
    a.address2,
    a.district,
    ci.city,
    co.country,
    a.postal_code,
    sf.first_name AS manager_first_name,
    sf.last_name AS manager_last_name,
    GETDATE() AS start_date,
    GETDATE() AS end_date
FROM 
    store s
    JOIN address a ON s.address_id = a.address_id
    JOIN city ci ON a.city_id = ci.city_id
    JOIN country co ON ci.country_id = co.country_id
    JOIN staff sf ON s.manager_staff_id = sf.staff_id;
