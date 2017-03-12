class Product < ApplicationRecord
  default_scope {order("products.name ASC")}
  scope :order_by_name, -> (type) {order("products.name #{type}")}
  belongs_to :user
  has_many :category_products
  has_many :categories, through: :category_products
  has_many :favorite_products
  has_many :m_users, through: :favorite_products, source: :user

  def self.load_products(page = 1, per_page = 10)
    includes(:categories,:m_users,user: [:events,:comments,:posts])
      .paginate(:page => page,:per_page => per_page)
  end

  def self.product_by_id(id)
    includes(:categories,:m_users,user: [:events,:comments,:posts])
      .find_by_id(id)
  end

  def self.products_by_ids(ids,page = 1, per_page = 10)
    load_products(page,per_page)
      .where(products:{
        id: ids
      })
  end

  def self.products_by_not_ids(ids,page = 1, per_page = 10)
    load_products(page,per_page)
      .where.not(products:{
        id: ids
      })
  end

  def self.products_by_user(user,page = 1, per_page = 10)
    load_products(page,per_page)
      .where(products:{
        user_id: user
      })
  end

  def self.products_by_category(category,page = 1, per_page = 10)
    joins(:categories).select("products.*")
      .group("products.id")
      .where(categories:{
        id: category
      }).paginate(:page => page,:per_page => per_page)
  end

  def self.products_follow_by_user(user,page = 1,per_page = 10)
    joins(:favorite_products).select("products.id")
      .group("products.id")
      .where(favorite_products:{
        user_id: user
      }).paginate(:page => page,:per_page => per_page)
  end

end
