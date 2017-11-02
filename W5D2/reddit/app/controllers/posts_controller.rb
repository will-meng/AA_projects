class PostsController < ApplicationController
  before_action :require_logged_in, except: [:show]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post.id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @comments_by_parent_id = comments_by_parent_id(@post)
    if @post
      render :show
    else
      redirect_to posts_url
    end
  end

  def comments_by_parent_id(post)
    hash = Hash.new { |h, k| h[k] = [] }
    post.comments.includes(:author).each do |comment|
      hash[comment.parent_comment_id] << comment
    end
    hash
  end

  def edit
    @post = Post.find_by(id: params[:id])
    if @post
      render :edit
    else
      redirect_to posts_url
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      render :show
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
