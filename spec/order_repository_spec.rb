# file: spec/order_repository_spec.rb
require 'order_repository.rb'

def reset_orders_table
  seed_sql = File.read('tables_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end


RSpec.describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  context '#all' do
    it 'returns all items' do
      repository = OrderRepository.new
      items = repository.all

      expect(items.length).to eq 4
      expect(items.first.id).to eq 1
      expect(items.first.customer_name).to eq('Cane Xay')
      expect(items.first.date_placed).to eq ('2023-05-01 01:10:10')
    end
  end

  context '#find' do
    it 'returns a single item by id' do
      repository = OrderRepository.new
      item = repository.find(1)

      expect(item.id).to eq '1'
      expect(item.customer_name).to eq('Cane Xay')
      expect(item.date_placed).to eq '2023-05-01 01:10:10'
    end
  end

  context '#create' do
    it 'creates a new order' do
      repository = OrderRepository.new
      order = Order.new
      order.id = 1
      order.customer_name = 'Cane Xay'
      order.date_placed = '2023-05-01 01:10:10'
      order.shop_item_id = 1

      repository.create(order)

      created_order = repository.find(1)
      expect(created_order.customer_name).to eq('Cane Xay')
      expect(created_order.date_placed).to eq('2023-05-01 01:10:10')
    end
  end
=begin

  context '#update' do
    it 'updates a single order' do
      repository = OrderRepository.new
      order = repository.find(1)
      order.customer_name = 'Cane Dan'
      
      repository.update(order)

      updated_order = repository.find(1)
      expect(updated_order.id).to eq(1)
      expect(updated_order.customer_name).to eq('Cane Dan')
      expect(updated_order.date_placed).to eq('2023-05-01 01:10:10')
      expect(updated_order.shop_item_id).to eq(1)
    end
  end
=end
  ##delete do

end
