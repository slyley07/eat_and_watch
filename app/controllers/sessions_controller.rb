class SessionsController < ApplicationController
  def create
    @user = User.find_by_email(params[:email])
    if @user and @user.password == params[:password]
      session[:user_id] = @user.id
      redirect_to posts_index_path, notice: 'Welcome back, #{@user.fname}'
    else
      flash[:alert] = "I can't let you do that, Dave"
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'You have been successfully logged out!'
  end
end
