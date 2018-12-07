class LikesController < ApplicationController
  
  def create
    @beat = Beat.find(params[:beat_id])
    respond_to do |format|
      if already_liked?
        flash.now[:notice] = "You can't like more than once!"
      else
        @beat.likes.create(user_id: current_user.id)
        # redirect_back(fallback_location: root_path)
        format.js { render 'beats/create.js.erb'}
      end
    end
  end

  def destroy
    @beat = Beat.find(params[:beat_id])
    @like = @beat.likes.find(params[:id])
    respond_to do |format|
      if !already_liked?
        flash.now[:notice] = "Can't unlike!"
      else
        @like.destroy
        format.js { render 'beats/create.js.erb'}
        # redirect_back(fallback_location: root_path)
      end
    end
  end

  private
    def already_liked?
      Like.where(user_id: current_user.id, beat_id: params[:beat_id]).exists?
    end
end
