#file:lib/order_repository.rb

require_relative 'order'

class OrderRepository

  def all
    sql = <<-SQL 
    SELECT id, customer_name, date_placed FROM orders;
    SQL

    results = DatabaseConnection.exec_params(sql, [])
    orders = []

    results.each do |record|
      order = Order.new
      order.id = record['id'].to_i
      order.customer_name = record['customer_name']
      order.date_placed = record['date_placed']

      orders << order
    end
    return orders
  end

  
  def find(id)
    sql = <<-SQL
    SELECT orders.id, orders.customer_name, orders.date_placed,
    shop_items.id AS item_id, shop_items.name, shop_items.unit_price, shop_items.quantity
    FROM orders
    JOIN shop_items ON shop_items.id = orders.shop_item_id
    WHERE orders.id = $1;
    SQL
  
    params = [id]
    results = DatabaseConnection.exec_params(sql, params)
  
    order = Order.new
    order.id = results.first['id']
    order.customer_name = results.first['customer_name']
    order.date_placed = results.first['date_placed']
  
    results.each do |record|
      item = Item.new
      item.id = record['item_id']
      item.name = record['name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity'].to_i

      order.items << item
    end
  
    return order
  end
  
  def create(order)
    # Insert into the shop_items_orders join table
    if order.items
      order.items.each do |item|
        #sql = 'INSERT INTO shop_items_orders (order_id, item_id) VALUES ($1, $2);'
        sql = <<-SQL
        INSERT INTO orders (customer_name, date_placed)
        VALUES ($1, $2) RETURNING id;
        SQL
        params = [order.customer_name, order.date_placed]
        result = DatabaseConnection.exec_params(sql, params)
        order.id = result.first['id']
      end
     
    else
      sql = <<-SQL
        INSERT INTO orders (customer_name, date_placed)
        VALUES ($1, $2) RETURNING id;
        SQL
        params = [order.customer_name, order.date_placed]
        result = DatabaseConnection.exec_params(sql, params)
        order.id = result.first['id']
    end
  end
 end
 
  # def update(order)
  # end

  # def delete(order)
  # end
#end