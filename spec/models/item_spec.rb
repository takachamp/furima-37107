require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の出品機能' do
    context '商品出品ができる場合' do
      it 'item_name, item_info, category_id, condition_id, shipping_cost_id, shipping_area_id, shipping_date_id, price, imageが存在すれば登録できる' do
        expect(@item).to be_valid
      end

      it 'priceが300円以上9,999,999円以下であれば登録できる' do
        @item.price = Faker::Number.between(from: 300, to: 9_999_999)
        expect(@item).to be_valid
      end
    end

    context '商品出品ができない場合' do
      it 'item_nameが空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it 'item_infoが空では登録できない' do
        @item.item_info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item info can't be blank")
      end

      it 'category_idが空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'condition_idが空では登録できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it 'shipping_cost_idが空では登録できない' do
        @item.shipping_cost_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping cost can't be blank")
      end

      it 'shipping_area_idが空では登録できない' do
        @item.shipping_area_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping area can't be blank")
      end

      it 'shipping_date_idが空では登録できない' do
        @item.shipping_date_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date can't be blank")
      end

      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが全角数字では登録できない' do
        @item.price = '/\A[０-９]+\z/'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid. Input half-width characters')
      end

      it '文字を含むpriceは登録できない' do
        @item.price = Faker::Lorem.characters(number: 5, min_alpha: 1, min_numeric: 4)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid. Input half-width characters')
      end

      it 'priceが300円未満では登録できない' do
        @item.price = Faker::Number.between(from: 1, to: 299)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end

      it 'priceが10,000,000円以上では登録できない' do
        @item.price = Faker::Number.number(digits: 8)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end

      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'ユーザーが紐付いていなければ登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
