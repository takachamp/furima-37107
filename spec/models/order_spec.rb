require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '購買情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @destination_order = FactoryBot.build(:destination_order, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば決済できる' do
        expect(@destination_order).to be_valid
      end

      it 'building_nameは空でも決済できる' do
        @destination_order.building_number = ''
        expect(@destination_order).to be_valid
      end

      it 'phone_numberは11桁の半角数字であれば決済できる' do
        @destination_order.phone_number = '01234567890'
        expect(@destination_order).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと決済できない' do
        @destination_order.postal_code = ''
        @destination_order.valid?
        expect(@destination_order.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと決済できない' do
        @destination_order.postal_code = '1234567'
        @destination_order.valid?
        expect(@destination_order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'shipping_area_idが空では決済できない' do
        @destination_order.shipping_area_id = ''
        @destination_order.valid?
        expect(@destination_order.errors.full_messages).to include("Shipping area can't be blank")
      end

      it 'shipping_area_idが1の場合、決済できない' do
        @destination_order.shipping_area_id = '1'
        @destination_order.valid?
        expect(@destination_order.errors.full_messages).to include("Shipping area can't be blank")
      end

      it 'phone numberが空では決済できない' do
        @destination_order.phone_number = ''
        @destination_order.valid?
        expect(@destination_order.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone numberは数字でないと決済できない' do
        @destination_order.phone_number = Faker::Lorem.characters(number: 11, min_alpha: 11)
        @destination_order.valid?
        expect(@destination_order.errors.full_messages).to include('Phone number Input only number')
      end

      it 'phone numberが全角数字では決済できない' do
        @destination_order.phone_number = '０１２３４５６７８９０'
        @destination_order.valid?
        expect(@destination_order.errors.full_messages).to include('Phone number Input only number')
      end

      it 'phone numberは10~11桁の半角数字でないと決済できない' do
        @destination_order.phone_number = Faker::Number.between(from: 1, to: 9)
        @destination_order.valid?
        expect(@destination_order.errors.full_messages).to include('Phone number Input only number')
      end

      it 'cityが空だと決済できない' do
        @destination_order.city = ''
        @destination_order.valid?
        expect(@destination_order.errors.full_messages).to include("City can't be blank")
      end

      it 'house numberが空だと決済できない' do
        @destination_order.house_number = ''
        @destination_order.valid?
        expect(@destination_order.errors.full_messages).to include("House number can't be blank")
      end

      it 'tokenが空だと決済できない' do
        @destination_order.token = ''
        @destination_order.valid?
        expect(@destination_order.errors.full_messages).to include("Token can't be blank")
      end

      it 'itemが紐付いていないと決済できない' do
        @destination_order.item_id = nil
        @destination_order.valid?
        expect(@destination_order.errors.full_messages).to include("Item can't be blank")
      end

      it 'userが紐付いていないと決済できないこと' do
        @destination_order.user_id = nil
        @destination_order.valid?
        expect(@destination_order.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
