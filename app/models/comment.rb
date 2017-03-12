class Comment < ApplicationRecord
  default_scope {order("comments.created_at DESC")}
  scope :order_by_created_at, -> (type) {order("comments.created_at #{type}")}
  belongs_to :post, optional: true
  belongs_to :user, optional: true
  has_many :images, as: :imageable
  has_many :replies, class_name: "Comment", foreign_key: "origin_id"
  belongs_to :origin, class_name: "Comment", optional: true

  def self.load_comments(page = 1, per_page = 10)
    includes(:images,:replies,:origin,post:[:images],user:[:posts,:products,:events])
      .paginate(:page => page,:per_page => per_page)
  end

  def self.comment_by_id(id)
    includes(:images,:replies,:origin,post:[:images],user:[:posts,:products,:events])
      .find_by_id(id)
  end

  def self.comments_by_ids(ids,page = 1, per_page = 10)
    load_comments(page,per_page)
      .where(comments: {
        id: ids
      })
  end

  def self.comments_by_not_ids(ids,page = 1, per_page = 10)
    load_comments(page,per_page)
      .where.not(comments: {
        id: ids
      })
  end

  def self.comments_by_replies(page = 1, per_page = 10)
    joins(:replies).select("comments.*")
      .group("comments.id")
      .paginate(:page => page, :per_page => per_page)
  end

  def self.comments_by_user(user,page = 1 ,per_page = 10)
    load_comments(page,per_page)
      .where(comments:{
        user_id: user
      })
  end

  def self.comments_by_post(post,page = 1 ,per_page = 10)
    load_comments(page,per_page)
      .where(comments:{
        post_id: post
      })
  end
  
end
