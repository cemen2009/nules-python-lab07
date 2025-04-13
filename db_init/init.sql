CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL CHECK (name <> '')
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL CHECK (name <> ''),
    type VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    discount DECIMAL(5,2) DEFAULT 0 CHECK (discount BETWEEN 0 AND 100)
);

CREATE TABLE warehouses (
    id SERIAL PRIMARY KEY,
    location VARCHAR(100) NOT NULL
);

CREATE TABLE stock (
    product_id INT REFERENCES products(id),
    warehouse_id INT REFERENCES warehouses(id),
    quantity INT DEFAULT 0 CHECK (quantity >= 0),
    PRIMARY KEY (product_id, warehouse_id)
);

CREATE TABLE purchases (
    id SERIAL PRIMARY KEY,
    client_id INT REFERENCES clients(id),
    product_id INT REFERENCES products(id),
    quantity INT NOT NULL CHECK (quantity > 0),
    purchase_date DATE DEFAULT CURRENT_DATE
);
