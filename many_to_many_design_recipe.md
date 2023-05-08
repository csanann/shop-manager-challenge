# Design Recipe for Shop Manager Project

1. Extract nouns from the user stories or specification

#### USER STORIES:

As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price.

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

As a shop manager
So I can manage items
I want to be able to create a new item.

As a shop manager
So I can know which orders were made
I want to keep a list of orders with their customer name.

As a shop manager
So I can know which orders were made
I want to assign each order to their corresponding item.

As a shop manager
So I can know which orders were made
I want to know on which date an order was placed. 

As a shop manager
So I can manage orders
I want to be able to create a new order.

#### Nouns:
shop_items, name, unit_price, quantity, orders, customer_name, date

2. Infer the Table Name and Columns

Record	Properties:
shop_items, name, unit_price, quantity, orders, customer_name, date

Name of the first table (always plural): shop_items
Column names: customer_name, date

Name of the second table (always plural): orders
id:SERIAL
customer_name: text
date: date

3. Decide the column types.

Table_1: shop_items
id:SERIAL
name: text
unit_price: numeric     ---#money deals with a single currency,simple?
quantity: integer

Table_2: orders
id:SERIAL
customer_name: text
date: date

4. Design the Many-to-Many relationship

Can one shop_items have many orders? (Yes)
Can one orders have many shop_items? (Yes)

5. Design the Join Table

Join table for tables: shop_items and orders
Join table name: shop_items_orders
Columns: shop_items_id, order_id

4. Write the SQL shop_seeds.

-- file: shop_items_orders.sql

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
 shop_item_id INTEGER
 PRIMARY KEY (shop_item_id, order_id)
 constraint shop_items_orders foreign key(shop_item_id) references shop_items(id) on delete cascade;
);

5. Create database and tables:

createdb shop_manager
createdb shop_manager_test

1st. psql -h 127.0.0.1 shop_manager_test < db/shop_seeds.sql
2nd. psql -h 127.0.0.1 shop_manager_test < db/tables_seeds.sql

6. Write sql tables_seeds:

---db/seeds.sql
TRUNCATE TABLE shop_items, orders RESTART IDENTITY;

INSERT INTO shop_items (name, unit_price, quantity) VALUES
('Item1', 10, 5),
('Item2', 15, 10),
('Item3', 20, 3),
('Item4', 25, 8);


INSERT INTO orders (customer_name, order_date, shop_item_id) VALUES
('Cane Xay', '2023-05-01 01:10:10', 1),
('Same Smith', '2023-05-02 02:20:20', 2),
('Alay Aoy', '2023-05-03 03:30:30', 3),
('Boy Babe', '2023-05-04 04:40:40', 4);

7. Define and Implement model classes:

Table name: shop_items
--#file: lib/shop_item.rb

class Item
  attr_accessor :id, :name:, unit_price, :quantity, :orders
  def initialize
    @orders = []
  end
end

Table name: orders
--#file: lib/order.rb

class Order
  attr_accessor :id, :customer_name:, :order_date, :shop_item_id

end

8. Write rspec testing drive for Repository classes
Table name: shop_items
--#file: spec/item_repository_spec.rb

#all
##get all items
repository = ItemRepository.new

items = repository.all
items.length -> 4
items.first.id -> 1
items.first.name -> 'Item1'
items.first.unit_price --> 10
items.first.quantity --> 5

#find
##get a single item by item_id
repository = ItemRepository.new

item = repository.find(1)

item.first.id -> 1
item.first.name -> 'Item1'
item.first.unit_price --> 10
item.first.quantity --> 5

##get another single item by item_id
repository = ItemRepository.new

item = repository.find(2)

item.first.id -> 2
item.first.name -> 'Item2'
item.first.unit_price --> 15
item.first.quantity --> 10
------------------
Table name: orders
--#file: spec/order_repository_spec.rb

#create
##create a new item
repository = OrderRepository.new

order = Order.new
order.id -> 1
order.customer_name -> 'Cane Xay'
order.date_placed --> '2023-05-01 01:10:10'
order.shop_item_id --> 1

repository.create(order) --> nil

orders = repository.all

created_order = repository.find(1)
created_order.customer_name --> 'Cane Xay'
created_order.date_placed --> '2023-05-01 01:10:10'
created_order.shop_item_id --> 1

#update
##update a single order

repository = OrderRepository.new

order = repository.find(1)

order.id -> 1
order.customer_name -> 'Cane Xay'
order.date_placed --> '2023-05-01 01:10:10'
order.shop_item_id --> 1

repository.update(order) --> nil

updated_orders = repository.find(1)

updated_order.id --> 1   >>>?
updated_order.customer_name --> 'Cane Dan'
updated_order.date_placed --> '2023-05-01 01:10:10'
updated_order.shop_item_id --> 1

#delete
##removes a single order by id
repository = OrderRepository.new

to_delete = 1

repository.delete(to_delete)

all_orders = repository.all

all_orders.length -->1
all_order.first.id -> 1
all_order.customer_name -> 'Cane Xay'
all_order.date_placed --> '2023-05-01 01:10:10'
all_order.shop_item_id --> 1


9. Define Repository classes

--#file: lib/item_repository.rb
class ItemRepository




--#file: lib/order_repository.rb
class OrderRepository.rb

9. Write integration tests includes the mocking IO
--#file; spec/shop_manager_integration_spec.rb

10. Write main.rb
