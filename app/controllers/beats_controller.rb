class BeatsController < ApplicationController

  def index
    @user = current_user
    @beat = Beat.new
    @beats = Beat.all
  end

  def new
    @beat = Beat.new
  end

  def edit
    @beat = Beat.find(params[:id])
  end

  def create
    @user = current_user
    @beat = @user.beats.new(beat_params)
    if @beat.save
      redirect_to :beats, notice: "Beat was successfully created"
    else
      redirect_to :beats, alert: "Beat couldn't be created"
    end
  end

  def destroy
    @beat = Beat.find(params[:id])
    if @beat.destroy
      redirect_to :beats, notice: "Beat was successfully removed"
    else
      redirect_to :beats, alert: "Beat couldn't be removed"
    end
  end

  private
  def beat_params
    params.require(:beat).permit(:name, :bpm, :key, :link)
  end
end
