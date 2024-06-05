class MenuItemsController < ApplicationController
  def index
    @menu_items = MenuItem.all
    render json: @menu_items
  end

  def destroy
    menu_item = MenuItem.find_by(id: params[:id])
    if menu_item&.destroy
      render json: { message: 'Item deleted successfully' }, status: :ok
    else
      render json: { error: 'Item not found' }, status: :not_found
    end
  end
end
