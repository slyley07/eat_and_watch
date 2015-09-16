class PostsController < ApplicationController
  def index
    @user = current_user
    @users = User.all
    @posts = Post.all.reverse
    @post = Post.new
    # @followers = @user.followers
    @f_posts = Post.subscribed current_user.following
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def show
    # @user = current_user
    @post = Post.find(params[:id])
  end

  def edit
    @user = current_user
    @post = Post.find(params[:id])
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, notice: "That's what you're eating and watching??"
    else
      redirect_to root_path, notice: 'Something went wrong!'
    end
  end

  def update
    @user = current_user
    @post = Post.find(params[:id])
    if @user and @post and @user == @post.user
      if @post.update(post_params)
        redirect_to @post, notice: 'Post was successfully edited'
      else
        render :edit
      end
    end
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:id])
    if @user and @post and @user == @post.user
      @post.destroy
      redirect_to @user, notice: 'You have deleted that post!'
    else
      flash[:alert] = 'Something went wrong with deleting that post'
      redirect_to @user
    end
  end

  private

  def post_params
    params.require(:post).permit(:food, :show).merge(user_id: current_user.id)
  end
end
