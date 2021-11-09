class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :item_name,        null: false
      t.text       :item_info,        null: false
      t.integer    :genre_id,         null: false
      t.integer    :category_id,      null: false
      t.integer    :condition_id,     null: false
      t.integer    :shipping_cost_id, null: false
      t.integer    :shipping_area_id, null: false
      t.integer    :shipping_date_id, null: false
      t.integer    :price,            null: false
      t.references :user,             null: false, foreig_key: true
      t.timestamps
    end
  end
end
