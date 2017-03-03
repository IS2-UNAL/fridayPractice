class Product < ApplicationRecord
  belongs_to :user,optional: true
  has_many :category_products
  has_many :categories, through: :category_product
end
