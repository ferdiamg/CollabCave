class StemsController < ApplicationController

  def index
    @stems = Stem.all
  end

  def show
    @stem = Stem.find(params[:id])
  end

  def new
    @stem = Stem.new
  end

  def create
    @beat = Beat.find(params[:beat_id])
    @stem = @beat.stems.new(stem_params)
    if @stem.save
      redirect_to :root
    else
      redirect_to :beats
    end
  end

  def destroy
    @beat = Beat.find(params[:beat_id])
    @stem = @beat.stems.find(params[:id])
    if @stem.destroy
      redirect_to :beats
    else
      redirect_to :root
    end
  end

  private
    def stem_params
      params.require(:stem).permit(:name, :link)
    end
end
