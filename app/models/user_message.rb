class UserMessage < ActiveRecord::Base
  attr_accessible :email, :message, :name
  validates :email, :message, :name, presence: true
end
