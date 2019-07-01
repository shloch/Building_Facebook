class Friendship < ApplicationRecord
    belongs_to :invited_friend    
    belongs_to :inviting_friend
end
