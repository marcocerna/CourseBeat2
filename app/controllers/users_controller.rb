class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create params[:user]
    # Other stuff
  end

  def show
    @user = current_user
    # Other stuff
  end

  def edit
    @user = current_user
  end

  def update
  end

  def destroy
  end

end
