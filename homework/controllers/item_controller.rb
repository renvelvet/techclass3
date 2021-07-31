require_relative '../models/item'

class ItemController 
  def list_item
    items = Item.find_all
    renderer = ERB.new(File.read('./views/index.erb'))
    renderer.result(binding)
  end

  def find_item(params)
    item = Item.find_with_categories(params['id'])
    if item != nil
      renderer = ERB.new(File.read('./views/show.erb'))
      renderer.result(binding)
    end
  end
end