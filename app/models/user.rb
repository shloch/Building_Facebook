class User < ApplicationRecord

  attr_accessor :login

  has_many :sent_invites, foreign_key: :inviting_id, class_name: 'Friendship'
  has_many :invited_friends, through: :sent_invites, :dependent => :destroy

  has_many :received_invites, foreign_key: :invited_id, class_name: 'Friendship'
  has_many :inviting_friends, through: :received_invites, :dependent => :destroy

  has_many :posts, foreign_key: :author_id, class_name: "Post", :dependent => :destroy
  has_many :post_comments, :dependent => :destroy
  has_many :like_posts, :dependent => :destroy

  validates :mobile,:presence => true,
                 :numericality => true,
                 :length => { :minimum => 6, :maximum => 15 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
      
  devise :omniauthable, omniauth_providers: [:facebook]

  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where("mobile = :value OR email = :value", value: login).first
    else 
      where(conditions.to_hash)
    end
    
  end

end
