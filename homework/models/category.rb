require_relative '../db/mysql_connector'

class Category
  attr_accessor :name, :id, :items
  
  def initialize(params)
    @name = params[:name]
    @id = params[:id]
    @items = []
  end

  def save
    return false unless valid?

    client = create_db_client
    client.query("insert into categories(name) values('#{name}')")
  end

  def valid?
    return false if @name.nil?
    true
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query("select * from categories order by id asc")

    convert_sql_result_to_array(raw_data)
  end

  def self.find_by_id(id)
    client = create_db_client
    raw_data = client.query("select *
    from categories
    where categories.id = #{id}")
   
    convert_sql_result_to_array(raw_data).first
  end
    
  def self.find_with_items(id)
    client = create_db_client
    raw_data = client.query("select items.id, items.name, items.price
    from items
    join item_categories on item_id = items.id
    where category_id = #{id}")

    category = find_by_id(id)
    items = []
    raw_data.each do |row|
      item = Item.new({
        id: row['id'],
        name: row['name'],
        price: row['price']
      })
      items << item
    end

    category.items = items
    category
  end

  def update 
    return false unless valid?
  
    client = create_db_client
    client.query("update categories set name = '#{name}'
    where id = #{id}")
  end

    
  def self.remove_by_id(id)
    client = create_db_client
    client.query("delete from categories where id = #{id}")
  end

  def self.convert_sql_result_to_array(result)
    categories = Array.new
  
    result.each do |row|
      category = Category.new({
        name:row['name'],
        id: row['id']
      })
  
      categories << category
    end
  
    categories
  end
end
  