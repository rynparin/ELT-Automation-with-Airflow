TRUNCATE TABLE date_dim;

INSERT INTO date_dim (date, year, quarter, day, month, week, is_weekend)
SELECT
  payment_date AS date,
  EXTRACT(YEAR FROM payment_date) AS year,
  EXTRACT(QUARTER FROM payment_date) AS quarter,
  EXTRACT(DAY FROM payment_date) AS day,
  EXTRACT(MONTH FROM payment_date) AS month,
  EXTRACT(WEEK FROM payment_date) AS week,
  CASE WHEN EXTRACT(DOW FROM payment_date) IN (0, 6) THEN true ELSE false END AS is_weekend
FROM payment;
