class User < ApplicationRecord
  has_many :sent_invites, foreign_key: :inviting_id, class_name: 'Friendship'
  has_many :invited_friends, through: :sent_invites, :dependent => :destroy

  has_many :received_invites, foreign_key: :invited_id, class_name: 'Friendship'
  has_many :inviting_friends, through: :received_invites, :dependent => :destroy

  has_many :posts, foreign_key: :author_id, class_name: "Post", :dependent => :destroy
  has_many :post_comments, :dependent => :destroy
  has_many :like_posts, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
