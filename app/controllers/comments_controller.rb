class CommentsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :load_commentable,:only => [:create]
	def create
	  @comment = @commentable.comments.build(comment_params)
	  @comment.user = current_user
	  respond_to do |format|
	    if @comment.save
	      format.html { redirect_to @commentable , :notice => "Great! Your comment has been posted."}
	    else
	      format.html { render :action => 'new' }
	    end
	  end
	end


	def vote
		@comment  = Comment.find(params[:id])
		if params[:vote] == "true"
			@comment.vote_by :voter => current_user
		else
			@comment.downvote_from current_user
		end		
		@likes = @comment.get_upvotes.size
		@dislikes = @comment.get_downvotes.size
	end

	def destroy
		comment = Comment.find_by_id(params[:id])
		comment.destroy
		redirect_to :back, :notice => "Your comment has been removed, you can write something else!"
	end


	protected
	def load_commentable
	  @commentable = params[:commentable_type].camelize.constantize.find(params[:commentable_id])
	end
	
	private
	 def comment_params
	    params.require(:comment).permit(:title, :body, :commentable_id, :commentable_type) 
	end
end
