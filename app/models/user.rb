class User < ApplicationRecord
  default_scope {order("users.email ASC")}
  scope :order_by_email, -> (type) {order("users.email #{type}")}
  has_many :posts
  has_many :comments
  has_many :products
  has_many :event_users
  has_many :events, through: :event_users
  has_many :favorite_products
  has_many :f_products, through: :favorite_products, source: :product

  def self.load_users(page = 1, per_page = 10)
    includes(:comments,:products,:events,:f_products,posts: [:images,:comments])
      .paginate(:page => page,:per_page => per_page)
  end

  def self.user_by_id(id)
    includes(:comments,:products,:events,:f_products,posts: [:images,:comments])
      .find_by_id(id)
  end

  def self.users_by_ids(ids,page = 1 ,per_page = 10)
    load_users(page,per_page)
      .where(users: {
        id: ids
      })
  end

  def self.users_by_not_ids(ids,page = 1 ,per_page = 10)
    load_users(page,per_page)
      .where.not(users: {
        id: ids
      })
  end

  def self.users_by_posts(page = 1, per_page = 10)
    joins(:posts).select("users.*")
      .group("users.id")
      .paginate(:page => page,:per_page => per_page)
  end

  def self.users_by_comments(page = 1, per_page = 10)
    joins(:comments).select("users.*")
      .group("users.id")
      .where(comments:{
        origin_id: nil
      })
      .paginate(:page => page,:per_page => per_page)
  end

  def self.users_by_products(page = 1, per_page = 10)
    joins(:products).select("users.*")
      .group("users.id")
      .paginate(:page => page,:per_page => per_page)
  end

  def self.users_by_replies(page = 1, per_page = 10)
    joins(:comments).select("users.*")
      .group("users.id")
      .where.not(comments:{
        origin_id: nil
      })
      .paginate(:page => page,:per_page => per_page)
  end

  def self.user_by_favorite_products(page = 1, per_page = 10)
    joins(:favorite_products).select("users.id")
      .group("users.id")
      .paginate(:page => page, :per_page => per_page)
  end


end
