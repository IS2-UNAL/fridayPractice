class Category < ApplicationRecord
  default_scope {order("categories.created_at ASC")}
  scope :order_by_name, -> (type) {order("categories.name  #{type}")}
  has_many :category_products, dependent: :destroy
  has_many :products, through: :category_products

  validates :name,:description,presence: true
  validates :name, uniqueness: true
  validates :name, length: {minimum: 3}

  def self.load_categories(page = 1, per_page = 10)
    includes(products: [:user,:m_users])
      .paginate(:page => page, :per_page => per_page)
  end

  def self.category_by_id(id)
    includes(products: [:user,:m_users])
      .find_by_id(id)
  end

  def self.categories_by_ids(ids,page = 1, per_page = 10)
    load_categories(page,per_page)
      .where(categories:{
        id: ids
      })
  end

  def self.categories_by_not_ids(ids,page = 1, per_page = 10)
    load_categories(page,per_page)
      .where.not(categories: {
          id: ids
      })
  end

  def self.categories_by_name(name,page = 1, per_page = 10)
    load_categories(page,per_page)
      .where("categories.name LIKE ?", "#{name.downcase}")
  end

  def self.categories_by_products(page = 1, per_page = 10)
    joins(:products).select("categories.*")
      .group("categories.id")
      .paginate(:page => page,:per_page => per_page)
  end

  def self.categories_by_products_by_user(page = 1,per_page = 10)
    joins(products: :m_users).select("categories.*")
      .group("categories.id")
      .paginate(:page => page,:per_page => per_page)
  end

end
