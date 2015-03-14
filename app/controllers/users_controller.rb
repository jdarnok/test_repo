class UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def generate_token
    @user = User.find(params[:id])
    @user.regenerate_auth_token
    respond_with @user
  end

end
