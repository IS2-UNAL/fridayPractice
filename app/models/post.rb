class Post < ApplicationRecord
  belongs_to :user
  has_many :images, as: :imageable, dependent: :destroy
  has_many :comments, dependent: :destroy
end
