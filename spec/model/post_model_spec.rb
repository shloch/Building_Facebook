require 'rails_helper'
require "spec_helper"


RSpec.describe Post, :type => :model do
    before :each do
        @user = FactoryBot.create(:user1) 
        @user2 = FactoryBot.create(:user2) 
    end

    context "Creating posts and comments" do
        
        it "Add new post" do
            total_posts = Post.count
            @post = FactoryBot.create(:post1, author_id: @user.id) 
            expect(Post.count).to eq(total_posts+1)
        end
        it "adding comments to post" do
            total_comments = PostComment.count
            post = FactoryBot.create(:post1, author_id: @user.id) 
            PostComment.create(comment_text: "first comment", user:@user, post:post) 
            PostComment.create(comment_text: "seond comment", user:@user2, post:post) 
            expect(PostComment.count).to eq(total_comments+2)
        end

        it "adding Like to post" do
            post = FactoryBot.create(:post1, author_id: @user.id) 
            total_likes = LikePost.where(post_id: post).count    
            LikePost.create(post: post, user: @user) 
            LikePost.create(post: post, user: @user2)  
            expect(LikePost.where(post_id: post).count).to eq(total_likes+2)
        end
    
    end
end