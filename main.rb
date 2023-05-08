#file: main.rb

# to solve the issue of  'cann't load shop_item.rb'
# by adding lib folder to the Ruby load path
$LOAD_PATH.unshift(File.join(__dir__, 'lib'))

require_relative 'lib/shop_item'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'
require_relative 'lib/database_connection'

DatabaseConnection.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })

def display_menu
  puts "Welcome to the shop management program!"
  puts
  puts "What do you want to do?"
  puts "  1 = list all shop items"
  puts "  2 = create a new item"
  puts "  3 = list all orders"
  puts "  4 = create a new order"
  puts "  q = quit program"
  puts
end


def list_shop_items(item_repository)
  items = item_repository.all
  puts "Here's a list of all shop items:"
  items.each do |item|
    puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
  end
  puts
end


def create_new_item(item_repository)
  puts "Enter the name of the new item:"
  name = gets.chomp
  puts "Enter the unit price of the new item:"
  unit_price = gets.chomp.to_f
  puts "Enter the quantity of the new item:"
  quantity = gets.chomp.to_i

  date_placed = Time.now

  item = Item.new
  item.name = name
  item.unit_price = unit_price
  item.quantity = quantity


  item_repository.create(item)
  puts "New item created!"
  puts
end


def list_orders(order_repository)
  orders = order_repository.all
  puts "Here's a list of all orders:"
  orders.each do |order|
    puts "##{order.id} Customer: #{order.customer_name} - Date placed: #{order.date_placed}"
  end
  puts
end

  ##puts "Enter the date the order was placed (format: YYYY-MM-DD HH:MM:SS):"
  ##date_placed = gets.chomp
  # even though it doesn't make sense for the user to input item id
  # we can change it later as this is just an example
def create_new_order(order_repository, item_repository)
  puts "Enter the customer name:"
  customer_name = gets.chomp
  shop_item_ids = []
  puts "Enter the shop item ID (more items: please use a comma to separate your item id):"
  shop_item_ids = gets.chomp.split(",").map(&:to_i)
  date_placed = Time.now
  order_args = { customer_name: customer_name, date_placed: date_placed }
  order = Order.new(order_args) # Pass the order_args hash here
  


  shop_item_ids.each do |shop_item_id|
    item = item_repository.find(shop_item_id)
    order.add_item(item)
  end
    
    order_repository.create(order)
    puts "New order created!"
    puts
  end
    
  

  def main
    item_repository = ItemRepository.new
    order_repository = OrderRepository.new
  
  
    loop do
      display_menu
      choice = gets.chomp
  
  
      case choice
      when '1'
        list_shop_items(item_repository)
      when '2'
        create_new_item(item_repository)
      when '3'
        list_orders(order_repository)
      when '4'
        create_new_order(order_repository, item_repository) # Pass both repositories as arguments
      when 'q', 'Q'
        break
      else
        puts "Invalid option. Please try again."
      end
    end
  
  
    puts "Thanks for using the shop management program!"
  end
  
  
  main
  