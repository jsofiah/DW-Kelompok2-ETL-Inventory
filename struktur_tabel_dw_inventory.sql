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
