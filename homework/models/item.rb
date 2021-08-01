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

  def save
    return false unless valid?

    client = create_db_client
    client.query("insert into items (name, price) values('#{name}', #{price})")    
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
   
    convert_sql_result_to_array(raw_data).first
  end

  def self.find_with_categories(id)
    client = create_db_client
    raw_data = client.query("select item_id, category_id, categories.name
    from categories
    join item_categories on categories.id = item_categories.category_id
    where item_id = #{id}
    order by category_id asc")

    categories = []
    item = find_by_id(id)
    raw_data.each do |row|
      category = Category.new({
        name: row['name'],
        id: row['category_id']
      })
      categories << category
    end

    item.categories = categories
    p item
    item
  end
  
  def update 
    return false unless valid?

    client = create_db_client
    client.query("update items set name = '#{name}', price = #{price}
    where id = #{id}")
  end

  def self.remove_by_id(id)
    client = create_db_client
    client.query("delete from items where id = #{id}")
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

  def valid?
    return false if @name.nil?
    return false if @price.nil?
    true
  end
end
