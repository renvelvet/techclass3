require_relative '../db/mysql_connector'
require_relative './item'

class ItemCategory
  attr_accessor :item_id, :category_id

  def initialize(params)
    @item_id = params[:item_id]
    @category_id = params[:category_id]
  end

  
  def save
    return false unless valid?

    client = create_db_client
    client.query("insert into item_categories(item_id, category_id) values (#{item_id}, #{category_id})")
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query("select * from item_categories")

    convert_sql_result_to_array(raw_data)
  end

  def self.remove_by_item_id(item_id)
    client = create_db_client
    client.query("delete from item_categories where item_id = #{item_id}")
  end
  
  def self.remove_by_category_id(category_id)
    client = create_db_client
    client.query("delete from item_categories where category_id = #{category_id}")
  end

  def self.convert_sql_result_to_array(result)
    item_categories = Array.new

    result.each do |row|
      item_category = ItemCategory.new({
        item_id:row['item_id'],
        category_id: row['category_id']
      })

      item_categories << item_category
    end

    item_categories
  end

  def update 
    return false unless valid?

    client = create_db_client
    client.query("update item_categories set category_id = #{category_id}
    where item_id = #{item_id}")
  end

  def valid?
    return false if @item_id.nil?
    return false if @category_id.nil?
    true
  end
end
