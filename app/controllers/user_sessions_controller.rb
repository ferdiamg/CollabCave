class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  before_action :disable_header, only: [:new]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember])
      redirect_to(:beats, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:login, notice: 'Logged out!')
  end
end
