class LikesController < ApplicationController
  
  def create
    session[:return_to] ||= request.referer

    @beat = Beat.find(params[:beat_id])
    if already_liked?
      flash[:notice] = "You can't like more than once!"
    else
      @beat.likes.create(user_id: current_user.id)
      # redirect_to beat_path(@beat)
      redirect_to session.delete(:return_to)
    end
  end

  def destroy
    session[:return_to] ||= request.referer

    @beat = Beat.find(params[:beat_id])
    @like = @beat.likes.find(params[:id])
    if !already_liked?
      flash[:notice] = "Can't unlike!"
    else
      @like.destroy
      redirect_to session.delete(:return_to)
    end
  end

  private
    def already_liked?
      Like.where(user_id: current_user.id, beat_id: params[:beat_id]).exists?
    end
end
