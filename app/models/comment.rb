class Comment < ApplicationRecord
  belongs_to :post, optional: true
  has_many :images, as: :imageable
  has_many :replies, class_name: "Comment", foreign_key: "origin_id"
  belongs_to :origin, class_name: "Comment", optional: true
end
