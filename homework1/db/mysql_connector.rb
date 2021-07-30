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

def get_item_detail(id)
  client = create_db_client
  rawData = client.query("select items.id, items.name, items.price, categories.name as 'category_name', categories.id as 'category_id'
  from items
  join item_categories on items.id = item_categories.item_id
  join categories on item_categories.category_id = categories.id 
  where items.id = #{id}")

  category = Category.new(rawData.first["category_name"], rawData.first["category_id"])
  item = Item.new(rawData.first["name"], rawData.first["price"], rawData.first["id"], category)

  item
end

def edit_item(id, name, price, category_id)
  client = create_db_client
  client.query("update items set name = '#{name}', price = #{price}
  where id = #{id}")
  client.query("update item_categories set category_id = #{category_id}
  where item_id = #{id}")
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

def create_new_item(name, price, category_id)
  client = create_db_client
  client.query("insert into items (name, price) values('#{name}', #{price})")
  id = get_all_items
  id = id.length
  client.query("insert into item_categories(item_id, category_id)
  values (#{id},#{category_id})")
end

def delete_item(id)
  client = create_db_client
  client.query("delete from item_categories where item_id = #{id}")
  client.query("delete from order_details where item_id = #{id}")
  client.query("delete from items where id = #{id}")
end