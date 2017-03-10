class Category < ApplicationRecord
  default_scope {order("categories.created_at ASC")}
  scope :order_by_name, -> (type) {order("categories.name  #{type}")}
  has_many :category_products, dependent: :destroy
  has_many :products, through: :category_products

  validates :name,:description,presence: true
  validates :name, uniqueness: true
  validates :name, length: {minimum: 3}

end
