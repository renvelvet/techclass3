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

  def edit_category(params)
    category = Category.find_by_id(params['id'])
    renderer = ERB.new(File.read('./views/edit_category.erb'))
    renderer.result(binding)
  end

  def update_category(params)
    category = Category.new({
      id: params['id'],
      name: params['name'],
    })
    category.update

    list_category
  end
end