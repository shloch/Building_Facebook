require 'rails_helper'
require 'spec_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = FactoryBot.create(:user1)
    @user2 = FactoryBot.create(:user2)
    @user3 = FactoryBot.create(:user3)
  end

  context 'Creating friends : ' do
    it 'send friend request' do
      # @user sends request to user2
      # @user3 sends request to user2
      total_requests_user2 = Friendship.where(invited_id: @user2).where(status: 'pending').count
      expect(total_requests_user2).to eq(0)
      @user.sent_invites.create(invited_friend: @user2)
      @user3.sent_invites.create(invited_friend: @user2)
      expect(Friendship.where(invited_id: @user2).where(status: 'pending').count).to eq(2)
    end
  end
end
