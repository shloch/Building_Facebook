class Post < ApplicationRecord
    belongs_to :author, class_name: "User" 
    has_many :post_comments
    has_many :like_posts 
end
