class Friendship < ApplicationRecord
    belongs_to :invited_friend, class_name: 'User', foreign_key: :invited_id
    belongs_to :inviting_friend, class_name: 'User', foreign_key: :inviting_id
end
