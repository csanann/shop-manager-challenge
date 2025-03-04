Shop Manager Project
=================
## Description
In this project, we build terminal program to manage a shop database containing items and orders. The user can create new items,view the list of items in stock, create new orders, and view the list of orders placed.

## What was done
- Implemented user stories belows for managing shop items and orders
- Integrated a database using the PG gem
- Created repository classes for managing items and orders
- Test-driven development approach to build the program
- Mocked IO in tests to handle user input
- Ensured test coverage using SimpleCov

## What was learned
- How to integrated a database using the PG gem
- Building repository classes
- Mocking IO in tests for user input handling
- Test-driven development approach
- Ensuring proper test coverage
- Tried various approaches to resolve the encountered issues
- Maintaining a calm and composed mental state while facing challenges

## Challenges and Unsolved Issues
We encountered an issue related to the 'initialize' method in the 'Order' class when creating a new order. Despite trying various approaches to solve the problem, the issue remained unresolved. However, it is important to note that the order was still saved in the database despite the error. The learning experience gained from troubleshooting the error was invaluable and contributed to the overall development process.

# Challenges requirement:
=======================================================================
* Feel free to use Google, your notes, books, etc. but work on your own
* If you refer to the solution of another coach or student, please put a link to that in your README
* If you have a partial solution, **still check in a partial solution**
* You must submit a pull request to this repo with your code next Monday morning

Challenge:
-------

Please start by [forking this repo](https://github.com/makersacademy/shop-manager-challenge/fork), then clone your fork to your local machine. Work into that directory.

We are going to write a small terminal program allowing the user to manage a shop database containing some items and orders.

User stories:
-------

```
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
```

Here's an example of the terminal output your program should generate (yours might be slightly different — that's totally OK):

```
Welcome to the shop management program!

What do you want to do?
  1 = list all shop items
  2 = create a new item
  3 = list all orders
  4 = create a new order

1 [enter]

Here's a list of all shop items:

 #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
 #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15
 (...)
```

Technical Approach:
-----

In this unit, you integrated a database by using the `PG` gem, and test-driving and building Repository classes. You can continue to use this approach when building this challenge.

[You'll also need to mock IO](https://github.com/makersacademy/golden-square/blob/main/mocking_bites/05_unit_testing_terminal_io_bite.md) in your integration or unit tests, since the program will ask for user input.

Notes on test coverage
----------------------

Please ensure you have the following **AT THE TOP** of your spec_helper.rb in order to have test coverage stats generated
on your pull request:

```ruby
require 'simplecov'
require 'simplecov-console'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  # SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start
```

You can see your test coverage when you run your tests. If you want this in a graphical form, uncomment the `HTMLFormatter` line and see what happens!
