class PostCommentsController < ApplicationController
  def create
    user = params[:user_id].to_i
    post = params[:post_id].to_i
    comment = params[:post_comment][:comment_text]
    @comment = PostComment.new(comment_text: comment, user_id: user, post_id: post)
    # @comment = PostComment.new(comment_params)
    if @comment.save
      flash[:info] = 'Comment succesfully added to post'
    else
      flash[:warning] = "Comment could not be added to post #{@comment.errors.messages}"
      p @comment.errors
    end
    # redirect_to controller: 'dashboard', action: 'home_page', uuid: params[:post_comment][:user_id].to_s+'356a19'
    redirect_to_back_or_default
  end

  def destroy
    # REDIRECT ARTICLE --> https://coderwall.com/p/ydzvaa/redirect-to-back-or-default-in-rails
    # render plain: "DESTROY COMMENT :  #{params[:id]} / previous link :  --> #{request.env['HTTP_REFERER']}"
    PostComment.find(params[:id]).destroy
    flash[:success] = 'Post deleted successfully'
    redirect_to_back_or_default
  end
end
