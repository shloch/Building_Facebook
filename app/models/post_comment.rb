class PostComment < ApplicationRecord
  validates :comment_text, presence: true
  belongs_to :post
  belongs_to :user
end
