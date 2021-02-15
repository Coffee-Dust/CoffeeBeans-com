class PostsController < ApplicationController
  before_action :logged_in_or_redirect, except: [:index, :show]
  before_action :check_owner, only: [:edit, :update, :destroy]

  def index
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    if params[:user_id].to_i == current_user.id
      @post = Post.new
    else
      redirect_to(new_user_post_path(current_user))
    end
  end

  def create
    @post = Post.new(content: post_params[:content], user: current_user)
    if @post.save
      redirect_to(user_post_path(current_user, @post))
    else
      render :new
    end
  end

  def edit
    
  end
  
  def update
    @post.update(post_params)
    if @post.save
      redirect_to(user_post_path(current_user, @post))
    else
      render :edit
    end
  end

  def destroy
    @post.delete
    redirect_to(user_path(current_user))
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def check_owner
    @post = Post.find_by(id: params[:id])
    if @post && @post.user == current_user
      return true
    else
      redirect_back(fallback_location: user_path(current_user))
    end
  end
end
