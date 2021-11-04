# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| first_name         | string | null: false |
| last_name          | string | null: false |
| first_name_reading | string | null: false | 
| last_name_reading  | string | null: false | 
| birthday           | string | null: false |


## Association
- has_one :buyer
- has_one :card
- has_one :order
- has_many :items

## cards テーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user_id            | references | null: false, foreign_key: true |
| buyer_id           | references | null: false, foreign_key: true |
| card_id            | string     | null: false                    |

## Association 

- belongs_to :user
- belongs_to :buyer

## buyers テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| postal_code        | string     | null: false                    |
| prefecture         | integer    | null: false                    |
| city               | string     | null: false                    |
| house_number       | string     | null: false                    | 
| building_number    | string     | null: false                    |
| phone_number       | integer    | null: false                    |
| user_id            | references | null: false, foreign_key: true |
| card_id            | references | null: false, foreign_key: true |

## Association

- has_one :card
- has_one :order
- belongs_to :user

## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item_name          | string     | null: false                    |
| item_info          | text       | null: false                    |
| category           | string     | null: false                    |
| condition          | string     | null: false                    | 
| shipping_cost      | string     | null: false                    |
| shipping_area      | string     | null: false                    |
| shipping_date      | string     | null: false                    |
| price              | integer    | null: false                    |
| user_id            | references | null: false, foreign_key: true |

# Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user_id            | references | null: false, foreign_key: true |
| buyer_id           | references | null: false, foreign_key: true |
| item_id            | references | null: false, foreign_key: true |

## Association

- belongs_to :user
- belongs_to :buyer
- belongs_to :item