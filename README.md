# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_reading | string | null: false               | 
| last_name_reading  | string | null: false               | 
| birthday           | date   | null: false               |


## Association

- has_many :orders
- has_many :items


## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item_name          | string     | null: false                    |
| item_info          | text       | null: false                    |
| category_id        | integer     | null: false                    |
| condition_id       | integer     | null: false                    | 
| shipping_cost_id   | integer     | null: false                    |
| shipping_area_id   | integer     | null: false                    |
| shipping_date_id   | integer     | null: false                    |
| price              | integer    | null: false                    |
| user_id            | references | null: false, foreign_key: true |


# Association

- belongs_to :user
- has_one :order


## orders テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user_id            | references | null: false, foreign_key: true |
| item_id            | references | null: false, foreign_key: true |

## Association

- belongs_to :user
- belongs_to :item
- has_one :destination

## destination テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| postal_code        | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| city               | string     | null: false                    |
| house_number       | string     | null: false                    | 
| building_number    | string     | null: false                    |
| phone_number       | string     | null: false                    |
| order_id           | references | null: false, foreign_key: true |


## Association

- belongs_to :order