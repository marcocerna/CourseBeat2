class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create params[:user]
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
