require_relative '../db/mysql_connector'

class Category
    attr_accessor :name, :id
  
    def initialize(params)
      @name = params[:name]
      @id = params[:id]
    end

    def self.find_all
      client = create_db_client
      raw_data = client.query("select * from categories")

      convert_sql_result_to_array(raw_data)
    end

    def self.find_by_id(id)
      client = create_db_client
      raw_data = client.query("select *
      from categories
      where categories.id = #{id}")
     
      convert_sql_result_to_array(raw_data).first
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
  