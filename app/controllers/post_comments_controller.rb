class PostCommentsController < ApplicationController
    def index
    end
  
    def create
        user = params[:user_id].to_i
        post = params[:post_id].to_i
        comment = params[:post_comment][:comment_text]
        @comment = PostComment.new(comment_text: comment, user_id:user, post_id:post) 
        #@comment = PostComment.new(comment_params)         
        if @comment.save
            flash[:info] = "Comment succesfully added to post"       
        else
            flash[:warning] = "Comment could not be added to post #{@comment.errors.messages}"  
            p @comment.errors
        end
        redirect_to controller: 'dashboard', action: 'home_page', uuid: params[:post_comment][:user_id].to_s+'356a19'        
    end
  
    def new
    end
  
    def show
  
    end
  
    def edit
    end
  
    def update
    end
  
      
      
  end
  