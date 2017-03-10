class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :products
  has_many :event_users
  has_many :events, through: :event_users
  has_many :favorte_products
  has_many :f_products, through: :favorite_products, source: :product

end
