class PostsController < ApplicationController
  

  def create
    @post = current_user.posts.build(post_params) 
    if @post.save
      flash[:info] = "Post succesfully created"
      redirect_to root_url
    else
      flash[:info] = "Post not created"
      render root_url
    end
  end

 
  def add_post_like
    user = params[:user_id]
    post = params[:post_id]
   
    if (!post_already_liked?(post,user))
      if (update_total_likes(post, user))
        flash[:info] = "Post succesfully liked"
        redirect_to root_url
      else
        flash[:info] = "Like unsuccessful"
        redirect_to root_url
      end
    else  
      flash[:warning] = "Post already liked by you"
      redirect_to root_url
    end
  end

  private

    def post_params
      params.require(:post).permit(:post_text)
    end

    def update_total_likes(post, user)
      LikePost.create(post_id: post, user_id: user) 
      p = Post.find(post)
      p.like_total += 1
      p.save
    end

    def post_already_liked?(post, user)
      LikePost.where(user_id:user, post_id:post).any?
    end

    
    
end
