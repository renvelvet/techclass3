require "erb"
require "./models/order.rb"

class OrderController
  def create_order(params)
    order = Order.new({
      reference_no: params["ref_no"],
      customer_name: params["cust_name"],
      data: params["date"],
    })
    order.save
    renderer = ERB.new(File.read("./views/order.erb"))
    renderer.result(binding)
  end

  def find_order(params)
    order = Order.find_by_reference_no(params["ref_no"])
    if order != nil
      renderer = ERB.new(File.read("./views/order.erb"))
      renderer.result(binding)
    end
  end

  def list_order
    order = Order.find_all
    renderer = ERB.new(File.read("./views/list_order.erb"))
    renderer.result(binding)
  end

  def edit_order(params)
    order = Order.new({
      reference_no: params["ref_no"],
      customer_name: params["cust_name"],
      data: params["date"],
    })
    order.update
    renderer = ERB.new(File.read("./views/order.erb"))
    renderer.result(binding)
  end

  def delete_order(params)
    Order.remove_by_reference_no(params["ref_no"])
    list_order
  end
end
