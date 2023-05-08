#file: shop_manager_integration_spec.rb

require 'stringio'
require 'main'


def simulate_input(input_str)
  $stdin = StringIO.new(input_str)
  $stdout = StringIO.new
end


def reset_std_io
  $stdin = STDIN
  $stdout = STDOUT
end


RSpec.describe "Shop Manager Integration Test" do
  after(:each) do
    reset_std_io
  end

  it 'lists shop items' do
    simulate_input("1\nq\n")

    main

    output = $stdout.string
    expect(output).to include("Here's a list of all shop items:")
  end

  it 'creates a new item' do
    simulate_input("2\nItemX\n25.0\n7\nq\n")

    main

    output = $stdout.string
    expect(output).to include("New item created!")
  end

  it 'lists orders' do
    simulate_input("3\nq\n")

    main

    output = $stdout.string
    expect(output).to include("Here's a list of all orders:")
  end

  it 'creates a new order' do
    simulate_input("4\nJohn Doe\n2023-05-01 01:10:10\n1\nq\n")

    main

    output = $stdout.string
    expect(output).to include("New order created!")
  end
end
