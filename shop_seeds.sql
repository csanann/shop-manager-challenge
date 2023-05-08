-- file: shop_seeds.sql

-- Create the first table.
CREATE TABLE shop_items (
 id SERIAL PRIMARY KEY,
 name TEXT,
 unit_price MONEY,
 quantity INTEGER
);


-- Create the second table.
CREATE TABLE orders (
id SERIAL PRIMARY KEY,
customer_name TEXT,
date_placed TIMESTAMP,
shop_item_id INTEGER,
CONSTRAINT fk_shop_items FOREIGN KEY(shop_item_id) REFERENCES shop_items(id) ON DELETE CASCADE
);