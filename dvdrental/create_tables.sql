CREATE TABLE actor (
    actor_id INTEGER NOT NULL PRIMARY KEY,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    last_update TIMESTAMP
);

CREATE TABLE country (
    country_id INTEGER NOT NULL PRIMARY KEY,
    country VARCHAR(50),
    last_update TIMESTAMP
);


CREATE TABLE city (
    city_id INTEGER NOT NULL PRIMARY KEY,
    city VARCHAR(50),
    country_id INTEGER REFERENCES country(country_id),
    last_update TIMESTAMP
);

CREATE TABLE address (
    address_id INTEGER NOT NULL PRIMARY KEY,
    address VARCHAR(50),
    address2 VARCHAR(50),
    district VARCHAR(20),
    city_id INTEGER REFERENCES city(city_id),
    postal_code VARCHAR(10),
    phone VARCHAR(20),
    last_update TIMESTAMP
);

CREATE TABLE category (
    category_id INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(25),
    last_update TIMESTAMP
);

CREATE TABLE store (
    store_id INTEGER NOT NULL PRIMARY KEY,
    address_id SMALLINT REFERENCES address(address_id)
    manager_staff_id SMALLINT REFERENCES staff(staff_id),
);

CREATE TABLE staff (
    staff_id INTEGER NOT NULL PRIMARY KEY,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    address_id SMALLINT REFERENCES address(address_id),
    email VARCHAR(50),
    store_id INTEGER,
    active BOOLEAN,
    username VARCHAR(16),
    password VARCHAR(40),
    last_update TIMESTAMP,
    picture VARCHAR(255),
    CONSTRAINT fk_store_id FOREIGN KEY (store_id) REFERENCES store(store_id)
);


ALTER TABLE store
ADD CONSTRAINT fk_manager_staff_id FOREIGN KEY (manager_staff_id) REFERENCES staff(staff_id);


CREATE TABLE customer (
    customer_id INTEGER NOT NULL PRIMARY KEY,
    store_id SMALLINT REFERENCES store(store_id),
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    email VARCHAR(50),
    address_id SMALLINT REFERENCES address(address_id),
    active BOOLEAN,
    create_date DATE,
    last_update TIMESTAMP
);

CREATE TABLE language (
    language_id INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(20),
    last_update TIMESTAMP
);

CREATE TABLE film (
    film_id INTEGER NOT NULL PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    release_year INTEGER,
    language_id SMALLINT REFERENCES language(language_id),
    rental_duration SMALLINT,
    rental_rate NUMERIC(4,2),
    length SMALLINT,
    replacement_cost NUMERIC(5,2),
    rating VARCHAR(10),
    special_features TEXT,
    fulltext TEXT
);

CREATE TABLE film_actor (
    actor_id SMALLINT REFERENCES actor(actor_id),
    film_id INTEGER REFERENCES film(film_id),
    last_update TIMESTAMP
);

CREATE TABLE film_category (
    film_id INTEGER REFERENCES film(film_id),
    category_id SMALLINT REFERENCES category(category_id),
    last_update TIMESTAMP
);

CREATE TABLE inventory (
    inventory_id INTEGER NOT NULL PRIMARY KEY,
    film_id INTEGER REFERENCES film(film_id),
    store_id SMALLINT REFERENCES store(store_id),
    last_update TIMESTAMP
);


CREATE TABLE rental (
    rental_id INTEGER NOT NULL PRIMARY KEY,
    rental_date TIMESTAMP,
    inventory_id INTEGER REFERENCES inventory(inventory_id),
    customer_id SMALLINT REFERENCES customer(customer_id),
    return_date TIMESTAMP,
    staff_id SMALLINT REFERENCES staff(staff_id),
    last_update TIMESTAMP
);


CREATE TABLE payment (
    payment_id INTEGER NOT NULL PRIMARY KEY,
    customer_id SMALLINT REFERENCES customer(customer_id),
    staff_id SMALLINT REFERENCES staff(staff_id),
    rental_id INTEGER REFERENCES rental(rental_id),
    amount NUMERIC(5,2),
    payment_date TIMESTAMP
);


