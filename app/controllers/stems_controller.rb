class StemsController < ApplicationController

  def new
    @stem = Stem.new
  end

  def create
    @beat = Beat.find(params[:beat_id])
    @stem = @beat.stems.new(stem_params)
    if @stem.save
      redirect_to @beat, notice: "Successfully added a stem to #{@beat.name}"
    else
      redirect_to @beat, alert: "Couldn't add a stem to #{@beat.name}"
    end
  end

  def destroy
    @beat = Beat.find(params[:beat_id])
    @stem = @beat.stems.find(params[:id])
    if @stem.destroy
      redirect_to @beat, notice: "Successfully added a stem to #{@beat.name}"
    else
      redirect_to @beat
    end
  end

  private
    def stem_params
      params.require(:stem).permit(:name, :link)
    end
end
