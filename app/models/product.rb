class Product < ApplicationRecord
  belongs_to :optional: true
  has_many :category_products
  has_many :categories, through: :category_product
  has_many :users
  has_many :favorite_products
  has_many :m_user, throught: :favorite_products, source: :user
end
