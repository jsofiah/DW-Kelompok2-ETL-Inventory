-- untuk di postgresql
CREATE TABLE dimcustomer (
    id_dimcustomer SERIAL PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(255),
    customer_email VARCHAR(255),
    customer_phone VARCHAR(50),
    customer_address TEXT,
    customer_credit_limit NUMERIC(12,2)
);

CREATE TABLE dimproduct (
    id_dimproduct SERIAL PRIMARY KEY,
    product_id VARCHAR(10),
    product_name VARCHAR(255),
    category_name VARCHAR(255),
    product_description TEXT,
    product_standard_cost NUMERIC(12,2),
    product_list_price NUMERIC(12,2),
    profit NUMERIC(12,2)
);