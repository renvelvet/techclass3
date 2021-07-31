require_relative '../db/mysql_connector'
require_relative './category'

class Item
  attr_accessor :id, :name, :price, :category

  def initialize(name, price, id, category = nil)
    @id = id
    @name = name
    @price = price
    @category = category
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query("select * from items")
    items = Array.new
  
    convert_sql_result_to_array(raw_data)
  end

  def self.find_by_id(id)
    client = create_db_client
    raw_data = client.query("select items.id, items.name, items.price, categories.name as 'category_name', categories.id as 'category_id'
    from items
    join item_categories on items.id = item_categories.item_id
    join categories on item_categories.category_id = categories.id 
    where items.id = #{id}")
   
    convert_sql_result_to_array(raw_data).first
  end

  def valid?
    return false if @name.nil?
    return false if @price.nil?
  end

  def self.convert_sql_result_to_array(result)
    items = Array.new

    result.each do |row|
      category = Category.new({
        name: row['category_name'],
        id: row['category_id']
      })

      item = Item.new({
        id: row['id'],
        name:row['name'],
        price: row['price'],
        category: category
      })

      items << item
    end

    items
  end
end
