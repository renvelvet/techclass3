require "sinatra"
require "./mysql_connector"

get "/" do
  items = get_all_items
  erb :index, locals: {
                items: items,
              }
end

get "/items/new" do
  categories = get_all_categories

  erb :create, locals: {
                 categories: categories,
               }
end

get "/items/:id" do
  id = params["id"]
  item = get_item_detail(id)
  erb :show, locals: {
               item: item,
             }
end

get "/items/edit/:id" do
  id = params["id"]
  item = get_item_detail(id)
  categories = get_all_categories
  erb :edit, locals: {
               item: item,
               categories: categories,
             }
end

get "/items/delete/:id" do
  id = params["id"]
  delete_item(id)

  redirect "/"
end

put "/items/edit/:id" do
  id = params["id"]
  name = params["name"]
  price = params["price"]
  category_id = params["category_id"]
  edit_item(id, name, price, category_id)

  redirect "/"
end

post "/items/create" do
  name = params["name"]
  price = params["price"]
  category_id = params["category_id"]

  create_new_item(name, price, category_id)
  redirect "/"
end
