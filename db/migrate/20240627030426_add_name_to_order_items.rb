class AddNameToOrderItems < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :name, :string
  end
end
