class LikesController < ApplicationController
  
  def create
    @beat = Beat.find(params[:beat_id])

    if already_liked?
      flash.now[:notice] = "You can't like more than once!"
    else
      @beat.likes.create(user_id: current_user.id)
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @beat = Beat.find(params[:beat_id])
    @like = @beat.likes.find(params[:id])
    if !already_liked?
      flash.now[:notice] = "Can't unlike!"
    else
      @like.destroy
      redirect_back(fallback_location: root_path)
    end
  end

  private
    def already_liked?
      Like.where(user_id: current_user.id, beat_id: params[:beat_id]).exists?
    end
end
