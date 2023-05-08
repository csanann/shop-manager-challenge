#file: lib/item_repository.rb

require 'shop_item'
require_relative 'database_connection'

class ItemRepository

  def all

    sql =  <<-SQL
    SELECT id, name, unit_price, quantity FROM shop_items;
    SQL

    results = DatabaseConnection.exec_params(sql, [])

    items = []

    results.each do |record|
      item = Item.new
      item.id = record['id'].to_i
      item.name = record['name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity']

      items << item
    end

    return items
  end

  def find(id)
    sql = <<-SQL
    SELECT id, name, unit_price, quantity FROM shop_items
    WHERE id = $1;
    SQL

    params = [id]

    results = DatabaseConnection.exec_params(sql, params)

    return nil if results.count == 0

    item = Item.new
    item.id = results.first['id'].to_i
    item.name = results.first['name']
    item.unit_price = results.first['unit_price']
    item.quantity = results.first['quantity'].to_i

    return item
  end


  def create(item)
    sql = <<-SQL
    INSERT INTO shop_items (name, unit_price, quantity) VALUES ($1, $2, $3)
    RETURNING id;
    SQL
 
    params = [item.name, item.unit_price, item.quantity]
    result = DatabaseConnection.exec_params(sql, params)

    item.id = result[0]['id'].to_i

    return item
 end
 
  # def update(item)

  # def delete(item)
end
