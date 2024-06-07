class MenuItemsController < ApplicationController
  def index
    @menu_items = MenuItem.all
    render json: @menu_items
  end

  def create
    @menu_item = MenuItem.new(menu_item_params)
    if @menu_item.save
      render json: @menu_item, status: :created
    else
      render json: @menu_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    menu_item = MenuItem.find_by(id: params[:id])
    if menu_item&.destroy
      render json: { message: 'Item deleted successfully' }, status: :ok
    else
      render json: { error: 'Item not found' }, status: :not_found
    end
  end

  private

  def menu_item_params
    params.require(:menu_item).permit(:name, :description, :price, :item_type)
  end
end
