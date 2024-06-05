class RenameTypeInMenuItems < ActiveRecord::Migration[6.1]
  def change
    rename_column :menu_items, :type, :item_type
  end
end