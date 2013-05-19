class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :asin
      t.text :desc
      t.string :image_url
      t.string :name
      t.string :buy_price
      t.string :rate
      t.integer :tag_id
      t.string :url
      t.string :listprice
      t.string :you_save
      t.string :price_msg
      t.string :rent_price
      t.string :prime_price
      t.string :download_price
      t.string :episode_price
      t.string :pass_episode_price
      t.text :customer_review

      t.timestamps
    end
  end
end
