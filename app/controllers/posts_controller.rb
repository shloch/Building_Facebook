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

  def edit
  end

  def update
  end

  private

    def post_params
      params.require(:post).permit(:post_text)
    end
end
