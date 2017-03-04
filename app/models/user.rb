class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :products
  has_many :event_users
  has_many :events, throught: :event_users
  has_many :favorte_products
  has_many :f_products, throught: :favorite_products, source: :product

end
