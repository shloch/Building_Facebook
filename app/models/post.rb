class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :post_comments, dependent: :destroy
  has_many :like_posts, dependent: :destroy

  validates :post_text, presence: true, length: { minimum: 3 }
end
