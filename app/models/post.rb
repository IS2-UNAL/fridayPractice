class Post < ApplicationRecord
  default_scope {order("posts.created_at DESC")}
  scope :order_by_created_at, -> (type) {order("posts.created_at #{type}")}
  belongs_to :user
  has_many :images, as: :imageable, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.load_posts(page = 1, per_page = 10)
    includes(:images,user: [:comments,:products,:events,:favorite_products])
      .paginate(:page => page,:per_page => per_page)
  end

  def self.post_by_id(id)
    includes(:images,user: [:comments,:products,:events,:favorite_products])
      .find_by_id(id)
  end

  def self.posts_by_ids(ids,page = 1, per_page = 10)
    load_posts(page,per_page)
      .where(posts:{
        id: ids
      })
  end

  def self.posts_by_not_ids(ids,page = 1, per_page = 10)
    load_posts(page,per_page)
      .where.not(posts:{
        id: ids
      })
  end

  def self.posts_by_user(user,page = 1, per_page = 10)
    load_posts(page,per_page)
      .where(posts:{
        user_id: user
      })
  end

  def self.posts_by_comments(page = 1, per_page = 10)
    joins(:comments).select("posts.*")
      .group("posts.id")
      .paginate(:page => page,:per_page => per_page)
  end

  def self.posts_by_comments_by_user(user,page = 1, per_page = 10)
    joins(comments: :user).select("posts.*")
      .group("posts.id")
      .where(users:{
        id: user
      })
      .paginate(:page => page,:per_page => per_page)
  end
end
