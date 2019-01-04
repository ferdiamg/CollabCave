class LikesController < ApplicationController

  def create
    @beat = Beat.friendly.find(params[:beat_id])
    respond_to do |format|
      if already_liked?
        redirect_to :beats, notice: "You can't like more than once!"
      else
        @beat.likes.create(user_id: current_user.id)
        format.js { render 'beats/likes.js.erb'}
      end
    end
  end

  def destroy
    @beat = Beat.friendly.find(params[:beat_id])
    @like = @beat.likes.find(params[:id])
    respond_to do |format|
      if already_liked?
        redirect_to :beats, notice: "You can't like more than once!"
      else
        @like.destroy
        format.js { render 'beats/likes.js.erb'}
      end
    end
  end

  private
    def already_liked?
      Like.where(user_id: current_user.id, beat_id: params[:beat_id]).exists?
    end
end
