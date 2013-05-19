class Page < ActiveRecord::Base
	extend FriendlyId
  friendly_id :title, use: :slugged

  attr_accessible :content, :title

  validates :title, presence: true, uniqueness: true

  
end
