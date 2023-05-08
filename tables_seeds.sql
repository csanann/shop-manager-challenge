---db/tables_seeds.sql
TRUNCATE TABLE shop_items, orders RESTART IDENTITY;

INSERT INTO shop_items (name, unit_price, quantity) VALUES
('Item1', 10, 5),
('Item2', 15, 10),
('Item3', 20, 3),
('Item4', 25, 8);

INSERT INTO orders (customer_name, date_placed, shop_item_id) VALUES
('Cane Xay', '2023-05-01 01:10:10', 1),
('Same Smith', '2023-05-02 02:20:20', 2),
('Alay Aoy', '2023-05-03 03:30:30', 3),
('Boy Babe', '2023-05-04 04:40:40', 4);
