#file: spec/item_repository_spec.rb

require 'item_repository'

def reset_shop_items_table
  seed_sql = File.read('tables_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
  before(:each) do 
    reset_shop_items_table
  end

  context '#all' do
    it 'returns all items' do
      repository = ItemRepository.new
      items = repository.all

      expect(items.length).to eq 4
      expect(items.first.id).to eq 1
      expect(items.first.name).to eq 'Item1'
      expect(items.first.unit_price).to eq '$10.00'
      expect(items.first.quantity).to eq '5'

      expect(items.last.id).to eq 4
      expect(items.last.name).to eq 'Item4'
      expect(items.last.unit_price).to eq '$25.00'
      expect(items.last.quantity).to eq '8'
    end
  end

  context '#find' do
    it 'returns orders by item id' do
      repository = ItemRepository.new
      item = repository.find(1)

      expect(item.id).to eq 1
      expect(item.name).to eq 'Item1'
      expect(item.unit_price).to eq '$10.00'
      expect(item.quantity).to eq 5
    
    end
  end

  context '#create' do
    it 'creates a new shop item' do
      repository = ItemRepository.new
      item = Item.new

      item.name = 'Item5'
      item.unit_price = 30
      item.quantity = 7

      repository.create(item)

      last_item = repository.all.last
      expect(last_item.id).to eq 5
      expect(last_item.name).to eq 'Item5'
      expect(last_item.unit_price).to eq '$30.00'
      expect(last_item.quantity).to eq '7'
    end
  end
=begin
  context '#update' do
    it 'updates a single shop item' do
      repository = ItemRepository.new
      item = repository.find(1)
      item.name = 'NewItem1'

      repository.update(item)

      updated_item = repository.find(1)
      expect(updated_item.id).to eq(1)
      expect(updated_item.name).to eq('NewItem1')
      expect(updated_item.unit_price).to eq(10)
      expect(updated_item.quantity).to eq(5)
    end
  end
  
  context '#delete' do
    it 'removes a single shop item by id' do
      repository = ItemRepository.new
      to_delete = 1
      repository.delete(to_delete)

      all_items = repository.all
      expect(all_items.length).to eq(3) # we have 4 items initially, and one is removed.
      deleted_item = repository.find(1)
      expect(deleted_item).to be_nil
    end
  end
=end  
end