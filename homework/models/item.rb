require_relative '../db/mysql_connector'
require_relative './category'

class Item
  attr_accessor :id, :name, :price, :categories

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @price = params[:price]
    @categories = []
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query("select * from items")
  
    convert_sql_result_to_array(raw_data)
  end

  def self.find_by_id(id)
    client = create_db_client
    raw_data = client.query("select *
    from items
    where items.id = #{id}")
   
    p convert_sql_result_to_array(raw_data).first 
    convert_sql_result_to_array(raw_data).first
  end

  def self.find_with_categories(id)
    client = create_db_client
    raw_data = client.query("select items.id, items.name, items.price, categories.name as 'category_name', categories.id as 'category_id'
    from items
    join item_categories on items.id = item_categories.item_id
    join categories on item_categories.category_id = categories.id 
    where items.id = #{id}")

    item = find_by_id(id)
    item.categories = Category.find_by_id(raw_data.first['category_id'])
    item
  end

  def valid?
    return false if @name.nil?
    return false if @price.nil?
  end

  def self.convert_sql_result_to_array(result)
    items = Array.new

    result.each do |row|
      item = Item.new({
        id: row['id'],
        name:row['name'],
        price: row['price']
      })

      items << item
    end

    items
  end
end
