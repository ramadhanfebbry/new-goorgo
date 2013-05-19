class Product < ActiveRecord::Base
  attr_accessible :asin, :desc, :image_url, :name, :buy_price, :rate, :tag_id, :url,
    :listprice, :you_save, :price_msg, :rent_price, :prime_price, :download_price, :episode_price, :pass_episode_price, :customer_review
  belongs_to :tag

  @products = Product.all
  paginates_per 10
end
