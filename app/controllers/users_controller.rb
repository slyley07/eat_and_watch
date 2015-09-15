class UsersController < ApplicationController
  before_action :current_u, only: [:index]

  before_action :set_user, only: [:show, :edit, :update, :close, :destroy]

  before_action :authenticate_user!, except: [:index, :new, :show]

  def index
    @users = User.all
    @user = User.new
  end

  def new
    @user = User.new
  end

  def show
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
    @user.update(user_params)
    redirect_to @user, notice: 'User was successfully updated!'
    # else
    #   render :edit
    # end
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
      flash[:notice] = "You're now following #{@user.username}"
      redirect_to posts_path
    else
      flash[:alert] = "There was a problem following that user!"
      redirect_to posts_path
    end
    # respond_to do |format|
    #   format.html { redirect_to posts_path }
    #   format.js { render nothing: true }
    # end
  end

  def unfollow
    @relationship = Relationship.find_by(follower_id: current_user, followed_id: params[:id])
    @user = User.find(params[:id])
    if @relationship and @relationship.destroy
      flash[:notice] = "You've successfully unfollowed #{@user.username}"
      # respond_to do |format|
      #   format.html { redirect_to posts_path }
      #   format.js { render nothing: true }
      # end
      # p "*****************************"
      redirect_to posts_path
    else
      flash[:alert] = "There was a problem unfollowing that user."
      # p "@@@@@@@@@@@@@@@@@@@@@@@@"
      # p @relationship
      redirect_to posts_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :fname, :birthday, :gender, :city)
  end

  def set_user
    begin
      @user = User.find(params[:id])
    rescue
      redirect_to posts_path
    end
  end

  def current_u
    @user = current_u
  end
end
