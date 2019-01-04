class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  before_action :disable_header, only: [:new]

  def new
    if logged_in?
      redirect_to :beats
    else
      @user = User.new
    end
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember])
      redirect_to(:beats, notice: 'Login successful')
    else
      redirect_to :login, alert: "Login failed! (Please check email and password)"
    end
  end

  def destroy
    logout
    redirect_to(:login, notice: 'Logged out!')
  end
end
