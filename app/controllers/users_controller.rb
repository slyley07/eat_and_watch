class UsersController < ApplicationController
  before_action :current_u, only: [:index, :edit, :update, :close, :destory ]

  before_action :authenticate_user!, except: [:index, :new, :show]

  def index
    @users = User.all
    @user = User.new
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
    @post = Post.new
  end

  def edit
  end

  def close
  end

  def create
    @user = User.new(user_params)
    p @user
    if @user.save
      session[:user_id] = @user.id
      redirect_to posts_path, notice: 'Your account was successfully created!'
    else
      redirect_to root_path, notice: 'Something went wrong!'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Use was successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    if @user.password == params[:user][:password]
      @user.destroy
      session[:user_id] = nil
      redirect_to root_path, notice: 'Your account was successfully closed'
    else
      flash[:alert] = 'Wrong password. Having second thoughts?'
      render :close
    end
  end

  def follow
    @relationship = Relationship.new(follower_id: current_user.id, followed_id: params[:id])
    @user = User.find(params[:id])
    if @relationship.save
      # respond_to do |format|
      #   format.js
      # end
      flash[:notice] = "You're now following #{@user.username}"
      redirect_to posts_path
    else
      flash[:alert] = "There was a problem following that user!"
      redirect_to posts_path
    end
  end

  def unfollow
    @relationship = Relationship.find_by(follower_id: current_user, followed_id: params[:id])
    @user = User.find(params[:id])
    if @relationships and @relationship.destroy
      flash[:notice] = "You've successfully unfollowed #{@user.username}"
      redirect_to posts_path
    else
      flash[:alert] = "There was a problem unfollowing that user."
      redirect_to posts_path
    end
    # redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :fname, :birthday, :gender, :city)
  end

  def current_u
    @user = current_u
  end
end
