class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @destination_order = DestinationOrder.new
  end

  def create
    @item = Item.find(params[:item_id])
    @destination_order = DestinationOrder.new(destination_params)
    if @destination_order.valid?
      @destination_order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private 
  
  def destination_params
    params.require(:destination_order).permit(:postal_code, :shipping_area_id, :city, :house_number, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end

  
end