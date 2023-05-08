#file: lib/order.rb

class Order
  attr_accessor :id, :customer_name, :date_placed, :shop_item_id, :items


  def initialize
    @items = []
  end

end
