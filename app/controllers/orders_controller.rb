class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:index, :create]
  def index
    @destination_order = DestinationOrder.new
    if @item.order.present?
    redirect_to root_path 
    else
    redirect_to root_path if @item.user.id == current_user.id
    end
  end

  def create
    @destination_order = DestinationOrder.new(destination_params)
    if @destination_order.valid?
      pay_item
      @destination_order.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def destination_params
    params.require(:destination_order).permit(:postal_code, :shipping_area_id, :city, :house_number, :building_number, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: destination_params[:token],
      currency: 'jpy'
    )
  end

  def set_order
    @item = Item.find(params[:item_id])
  end
end
