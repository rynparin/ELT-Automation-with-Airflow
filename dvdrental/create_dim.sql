CREATE TABLE Date_DIM
(
    date_key INT IDENTITY(1,1) PRIMARY KEY,
    date DATE NOT NULL,
    year SMALLINT NOT NULL,
    quarter SMALLINT NOT NULL,
    day SMALLINT NOT NULL,
    month SMALLINT NOT NULL,
    week SMALLINT NOT NULL,
    is_weekend BOOLEAN NOT NULL
);


CREATE TABLE Store_DIM
(
    store_key INT IDENTITY(1,1) PRIMARY KEY,
    store_id SMALLINT NOT NULL,
    address VARCHAR(50) NOT NULL,
    address2 VARCHAR(50),
    district VARCHAR(20) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    postal_code VARCHAR(10),
    manager_first_name VARCHAR(45) NOT NULL,
    manager_last_name VARCHAR(45) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);


CREATE TABLE Customer_DIM
(
    customer_key INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    email VARCHAR(50),
    address VARCHAR(50) NOT NULL,
    address2 VARCHAR(50),
    district VARCHAR(20) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    postal_code VARCHAR(10),
    create_date TIMESTAMP NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);


CREATE TABLE Film_DIM
(
    film_key INT IDENTITY(1,1) PRIMARY KEY,
    film_id SMALLINT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(MAX),
    release_year SMALLINT,
    language VARCHAR(20) NOT NULL,
    original_language VARCHAR(20),
    rental_duration SMALLINT NOT NULL,
    length SMALLINT NOT NULL,
    rating VARCHAR(5),
    special_features VARCHAR(MAX)
);


CREATE TABLE Sales_Fact
(
    sales_key INT IDENTITY(1,1) PRIMARY KEY,
    date_key INT NOT NULL,
    store_key INT NOT NULL,
    customer_key INT NOT NULL,
    film_key INT NOT NULL,
    sales_amount NUMERIC(5,2) NOT NULL,
    CONSTRAINT fk_date_key FOREIGN KEY (date_key) REFERENCES Date_DIM(date_key),
    CONSTRAINT fk_store_key FOREIGN KEY (store_key) REFERENCES Store_DIM(store_key),
    CONSTRAINT fk_customer_key FOREIGN KEY (customer_key) REFERENCES Customer_DIM(customer_key),
    CONSTRAINT fk_film_key FOREIGN KEY (film_key) REFERENCES Film_DIM(film_key)
);
