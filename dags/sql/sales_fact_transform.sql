TRUNCATE TABLE sales_fact;

INSERT INTO sales_fact (date_key, customer_key, store_key, film_key, sales_amount)
SELECT 
  dd.date_key, 
  cd.customer_key, 
  sd.store_key, 
  fd.film_key, 
  p.amount as sales_amount
FROM 
  payment p
  JOIN customer_dim cd ON p.customer_id = cd.customer_id
  JOIN date_dim dd ON CAST(p.payment_date AS DATE) = dd.date
  JOIN rental r ON p.rental_id = r.rental_id
  JOIN inventory i ON r.inventory_id = i.inventory_id
  JOIN store_dim sd ON sd.store_id = i.store_id
  JOIN film_dim fd ON fd.film_id = i.film_id;
