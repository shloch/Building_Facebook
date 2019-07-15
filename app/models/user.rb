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
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
      

  scope :all_friends, -> {includes(:inviting_friends).includes(:invited_friends)}
  
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where("mobile = :value OR email = :value", value: login).first
    else 
      where(conditions.to_hash)
    end
    
  end

  def User.users_except_me_with_their_friends(me)
    User.all.where.not(id:me.id).all_friends
  end

  #---omniauth functions ---

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

end
