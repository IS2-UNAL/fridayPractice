class Product < ApplicationRecord
  belongs_to :user
  has_many :category_products
  has_many :categories, through: :category_products
  has_many :favorite_products
  has_many :m_user, through: :favorite_products, source: :user
end
