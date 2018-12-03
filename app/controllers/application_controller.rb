class ApplicationController < ActionController::Base
  before_action :require_login

  def index
  end

  private
    def not_authenticated
      redirect_to login_path, alert: 'Please login first!'
    end

    def disable_header
      @disable_header = true
    end
end
