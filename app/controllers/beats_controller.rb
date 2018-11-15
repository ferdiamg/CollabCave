class BeatsController < ApplicationController

  def index
    @user = current_user
    @beat = Beat.new
    @beats = Beat.all
  end

  def new
    @beat = Beat.new
  end

  def create
    @user = current_user
    @beat = @user.beats.new(beat_params)
    if @beat.save
      redirect_to root_path, notice: "Beat was successfully created"
    else
      redirect_to root_path, alert: "Beat couldn't be created"
    end
  end

  private
  def beat_params
    params.require(:beat).permit(:name, :bpm, :key, :link)
  end
end
