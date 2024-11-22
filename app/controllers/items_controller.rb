class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :user, :image, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_duration_id).merge(user_id: current_user.id) # rubocop:disable Layout/LineLength
  end

  def move_to_index
    redirect_to new_user_session_path
  end
end
