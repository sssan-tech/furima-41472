class OrdersController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!, only: :index
  before_action :move_to_index, only: :index

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    redirect_to root_path unless current_user.id != @item.user.id && @item.order.blank?
  end

  def order_params
    params.require(:order_address).permit(:postcode, :prefecture_id, :city, :block, :building, :phone).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token]) # rubocop:disable Layout/LineLength
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
