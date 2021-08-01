require_relative '../models/item'
require_relative '../models/category'
require_relative '../models/item_category'

class ItemController 
  def list_item
    items = Item.find_all
    renderer = ERB.new(File.read('./views/index.erb'))
    renderer.result(binding)
  end

  def find_item(params)
    item = Item.find_with_categories(params['id'])
    if item != nil
      renderer = ERB.new(File.read('./views/show_item.erb'))
      renderer.result(binding)
    end
  end

  def new_item
    categories = Category.find_all
    renderer = ERB.new(File.read('./views/create_item.erb'))
    renderer.result(binding)
  end

  def create_item(params)
    item = Item.new({
      name:params['name'],
      price: params['price']
    })
    item.save

    item_id = Item.find_all.last.id
    item_category = ItemCategory.new({
      item_id: item_id,
      category_id: params['category_id']
    })
    item_category.save

    list_item
  end

  def edit_item(params)
    item = Item.find_with_categories(params['id'])
    categories = Category.find_all
    renderer = ERB.new(File.read('./views/edit_item.erb'))
    renderer.result(binding)
  end

  def update_item(params)
    item = Item.new({
      id: params['id'],
      name: params['name'],
      price: params['price']
    })
    item.update

    item_category = ItemCategory.new({
      item_id: params['id'],
      category_id: params['category_id']
    })
    item_category.update

    list_item
  end

  def delete_item(params)
    ItemCategory.remove_by_item_id(params['id'])
    Item.remove_by_id(params['id'])
    list_item
  end
end