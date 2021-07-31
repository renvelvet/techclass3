require "sinatra"
require_relative './controllers/item_controller'
require_relative './controllers/item_category_controller'

$item_controller = ItemController.new
# $item_category_controller = ItemCategoryController.new

get "/" do
  controller = $item_controller
  controller.list_item
end

get "/items/new" do
  controller = $item_controller
  controller.new_item
end

post "/items/create" do
  controller = $item_controller
  controller.create_item(params)
end

get "/items/:id" do
  controller = $item_controller
  controller.find_item(params)
end


# get "/items/:id/edit" do
#   id = params["id"]
#   item = get_item_detail(id)
#   categories = get_all_categories
#   erb :edit, locals: {
#     item: item,
#     categories: categories,
#   }
# end

# get "/items/:id/delete" do
#   id = params["id"]
#   delete_item(id)

#   redirect "/"
# end

# put "/items/:id/edit" do
#   id = params["id"]
#   name = params["name"]
#   price = params["price"]
#   category_id = params["category_id"]

#   edit_item(id, name, price, category_id)
#   redirect "/"
# end

