class OrderItemSerializer < ActiveModel::Serializer
  attributes :quantity, :price
  belongs_to :menu_item
end