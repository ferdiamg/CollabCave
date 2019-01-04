class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :disable_header, only: [:new]

  def show
    @user = User.friendly.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    if params[:beta_key] == "CC2018"
      @user = User.new(user_params)
      if @user.save
        redirect_to :beats, notice: 'Successfully registered.'
      else
        redirect_to :register, alert: @user.errors.full_messages
      end
    else
      redirect_to :register, alert: "Wrong Beta Key!"
    end
  end

  def edit
    @user = User.friendly.find(params[:id])
    redirect_to :root unless @user.id == current_user.id
  end

  def update
    @user = User.friendly.find(params[:id])
    redirect_to :root unless @user.id == current_user.id
    if @user.valid_password?(user_params[:password])
      if @user.update(user_params)
        redirect_to edit_user_path, notice: 'Successfully updated your profile.'
      else
        redirect_to edit_user_path, notice: "Couldn't update your profile!"
      end
    else
      redirect_to edit_user_path, notice: "Couldn't update your profile!"
    end
  end

  def destroy
    @user = User.friendly.find(params[:id])
    redirect_to :root unless @user.id == current_user.id
    if @user.destroy
      redirect_to :root, notice: 'Thats sad, see you soon!'
    else 
      redirect_to edit_user_path, notice: "Account couldn't be deleted!"
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation)
    end
end
