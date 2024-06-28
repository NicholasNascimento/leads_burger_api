class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total, :created_at
  has_many :order_items
end