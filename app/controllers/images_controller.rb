class ImagesController < ApplicationController
  def new
    @user = current_user
    @image = Image.new(user: @user)
  end

  def create
    @user = current_user
    @image = Image.new(params.require(:image).permit(:image).merge(user: current_user))
    if @image.save
      redirect_to @user
    else
      redirect_to edit_user_path(@user)
    end
  end

  def update
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
  end
end
