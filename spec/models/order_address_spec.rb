require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    item = FactoryBot.create(:item)
    user = FactoryBot.create(:user)
    @order_address = FactoryBot.build(:order_address, item_id: item.id, user_id: user.id)
    sleep 0.01
  end

  describe '商品購入機能' do
    context '商品購入できるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end
      it 'buildingが空でも保存できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
      it 'phoneが10桁でも保存できる' do
        @order_address.phone = Faker::Number.leading_zero_number(digits: 10)
        expect(@order_address).to be_valid
      end
    end

    context '商品購入できないとき' do
      it 'cityが空では保存できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'blockが空では保存できない' do
        @order_address.block = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Block can't be blank")
      end
      it 'postcodeが空では保存できない' do
        @order_address.postcode = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode can't be blank")
      end
      it 'postcodeにハイフンが含まれなければ保存できない' do
        @order_address.postcode = '1230854'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid. Enter it as follows (e.g. 123-4567)") # rubocop:disable Style/StringLiterals
      end
      it 'postcodeが数字でないと保存できない' do
        @order_address.postcode = 'abc-0854'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid. Enter it as follows (e.g. 123-4567)") # rubocop:disable Style/StringLiterals
      end
      it 'phoneが空では保存できない' do
        @order_address.phone = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone can't be blank")
      end
      it 'phoneにハイフンが含まれる場合保存できない' do
        @order_address.phone = '050-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone is invalid. Enter it as follows(e.g. 09012345678)") # rubocop:disable Style/StringLiterals
      end
      it 'phoneが10桁より少ない場合保存できない' do
        @order_address.phone = Faker::Number.leading_zero_number(digits: 9)
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone is invalid. Enter it as follows(e.g. 09012345678)") # rubocop:disable Style/StringLiterals
      end
      it 'prefectureが0のままでは保存できない' do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'user_idが空では保存できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では保存できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では保存できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
