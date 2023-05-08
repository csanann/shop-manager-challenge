#file: lib/shop_item.rb
#Table name: items

class Item
  attr_accessor :id, :name, :unit_price, :quantity, :orders

  def initialize
    @orders = []
  end
end