class PostsController < ApplicationController
  

  def create
    @post = current_user.posts.build(post_params) 
    if @post.save
      flash[:info] = "Post succesfully created"
      #redirect_to root_url
      redirect_to_back_or_default
    else
      flash[:warning] = "Post could not be created : #{@post.errors.full_messages}"
      #redirect_to root_url
      redirect_to_back_or_default
    end
  end

 
  def add_post_like
    user = params[:user_id]
    post = params[:post_id]
   
    if (!post_already_liked?(post,user))
      if (update_total_likes(post, user))
        flash[:info] = "Post succesfully liked"
        #redirect_to root_url
        redirect_to_back_or_default
      else
        flash[:info] = "Like unsuccessful"
        #redirect_to root_url
        redirect_to_back_or_default
      end
    else  
      flash[:warning] = "Post already liked by you"
      #redirect_to root_url
      redirect_to_back_or_default
    end
  end

  def destroy
    #render plain: "DESTROY POST :  #{params[:id]}"
    post = Post.find(params[:id])
    if (post.author == @logged_user)
      post.destroy
      flash[:success] = "Post deleted successfully"
    else  
      flash[:warning] = "WARNING !!! -- You are not the author of this post"
    end
    redirect_to_back_or_default
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
