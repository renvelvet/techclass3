require "sinatra"
require_relative './controllers/item_controller'
require_relative './controllers/category_controller'

$item_controller = ItemController.new
$category_controller = CategoryController.new

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

get "/items/:id/edit" do
  controller = $item_controller
  controller.edit_item(params)
end

put "/items/:id/edit" do
  controller = $item_controller
  controller.update_item(params)
end

get "/items/:id/delete" do
  controller = $item_controller
  controller.delete_item(params)
end

get "/categories" do
  controller = $category_controller
  controller.list_category
end

get "/categories/new" do
  controller = $category_controller
  controller.new_category
end

post "/categories/create" do
  controller = $category_controller
  controller.create_category(params)
end

get "/categories/:id" do
  controller = $category_controller
  controller.find_category(params)
end

get "/categories/:id/edit" do
  controller = $category_controller
  controller.edit_category(params)
end

put "/categories/:id/edit" do
  controller = $category_controller
  controller.update_category(params)
end

get "/categories/:id/delete" do
  controller = $category_controller
  controller.delete_category(params)
end
