class Friendship < ApplicationRecord
  belongs_to :invited_friend, class_name: 'User', foreign_key: :invited_id
  belongs_to :inviting_friend, class_name: 'User', foreign_key: :inviting_id

  scope :get_my_friends, -> { includes(:invited_friend).where(status: 'accepted') }
  scope :get_my_fr_request, -> { includes(:invited_friend).where(status: 'pending') }

  def self.get_friends_of_user(user)
    Friendship.where(inviting_friend: user).get_my_friends
  end

  def self.get_friend_requests(user)
    Friendship.where(inviting_friend: user).get_my_fr_request
  end
end
