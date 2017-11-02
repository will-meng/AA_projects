class CommentsController < ApplicationController
  before_action :require_logged_in, except: [:show]

  def new
    @comment = Comment.new
    @comment.post_id = params[:post_id]
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to post_url(params[:post_id])
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find_by(id: params[:id])
    if @comment
      render :show
    else
      redirect_to subs_url
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id)
  end
end
