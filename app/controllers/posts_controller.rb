class PostsController < ApplicationController
  def index
  end

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

  def new
  end

  def show

  end

  def edit
  end

  def update
  end

  def add_post_like
    
    if LikePost.create(post_id: params[:post_id], user_id: params[:user_id])
      flash[:info] = "Post succesfully liked"
      redirect_to root_url
    else
      flash[:info] = "Like unsuccessful"
      redirect_to root_url

    end

  end

  private

    def post_params
      params.require(:post).permit(:post_text)
    end
end
