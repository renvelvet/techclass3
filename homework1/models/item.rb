class Item
  attr_accessor :id, :name, :price, :category

  def initialize(name, price, id, category = nil)
    @id = id
    @name = name
    @price = price
    @category = category
  end
end
