require_relative '../models/category'
require_relative '../models/item_category'

class CategoryController 
  def list_category
    categories = Category.find_all
    renderer = ERB.new(File.read('./views/categories.erb'))
    renderer.result(binding)
  end

  def new_category
    renderer = ERB.new(File.read('./views/create_category.erb'))
    renderer.result(binding)
  end

  def create_category(params)
    category = Category.new({
      name:params['name']
    })
    category.save

    list_category
  end
end