class OrdersController < ApplicationController
  before_action :authenticate_request

  def create
    if @current_user
      order = @current_user.orders.build(order_params)
      if order.save
        render json: order, status: :created
      else
        render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Not authenticated' }, status: :unauthorized
    end
  end

  def index
    orders = @current_user.orders.includes(order_items: :menu_item)
    render json: orders.map { |order|
      {
        id: order.id,
        total: order.total,
        created_at: order.created_at,
        order_items: order.order_items.map { |item|
          {
            menu_item_id: item.menu_item_id,
            name: item.name,
            quantity: item.quantity,
            price: item.price
          }
        }
      }
    }
  end

  private

  def order_params
    params.require(:order).permit(:total, order_items_attributes: [:menu_item_id, :quantity, :price, :name])
  end
end
