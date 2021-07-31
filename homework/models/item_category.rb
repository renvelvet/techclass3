require_relative '../db/mysql_connector'

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

  # def add_item_category(item_id, category_id)
  #   item_category = ItemCategory.new({
  #     item_id: item_id,
  #     category_id: category_id
  #   })

  #   item_category.save
  #   item_category
  # end

  def self.find_all
    client = create_db_client
    raw_data = client.query("select * from item_categories")

    convert_sql_result_to_array(raw_data)
  end

  def self.find_by_item_id(id)
    client = create_db_client
    raw_data = client.query("select *
    from item_categories
    where item_id = #{id}")
   
    convert_sql_result_to_array(raw_data).first
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

  def valid?
    return false if @item_id.nil?
    return false if @category_id.nil?
    true
  end
end
