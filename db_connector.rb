require "mysql2"
require "./item"
require "./category"

def create_db_client
  client = Mysql2::Client.new(
    :host => "localhost",
    :username => "root",
    :password => "password",
    :database => "food_oms_db",
  )

  client
end

def get_all_items
  client = create_db_client
  rawData = client.query("select * from items")
  items = Array.new

  rawData.each do |data|
    item = Item.new(data["name"], data["price"], data["id"])
    items.push(item)
  end

  items
end

def get_all_categories
  client = create_db_client
  categories = client.query("select * from categories")
end

def get_all_item_with_categories
  client = create_db_client
  rawData = client.query("select items.id, items.name, categories.name as 'category_name', categories.id as 'category_id'
    from items
    join item_categories on items.id = item_categories.item_id
    join categories on item_categories.category_id = categories.id
    ")
  items = Array.new

  rawData.each do |data|
    category = Category.new(data["category_name"], data["category_id"])
    item = Item.new(data["name"], data["price"], data["id"], category)
    items.push(item)
  end

  items
end

def get_items_cheaper_than(price)
  client = create_db_client
  items = client.query("select * from items where price < #{price}")
end

def create_new_item(name, price)
  client = create_db_client
  client.query("insert into items (name, price) values('#{name}', #{price})")
end
