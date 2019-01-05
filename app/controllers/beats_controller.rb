class BeatsController < ApplicationController
  before_action :require_login
  helper_method :beat_liked_by_user

  def index
    respond_to do |format|
      @user = current_user
      @beat = Beat.new

      @beats = Beat.where(nil) # creates an anonymous scope
      @beats = @beats.from_bpm(params[:from_bpm]) if params[:from_bpm].present?
      @beats = @beats.to_bpm(params[:to_bpm]) if params[:to_bpm].present?
      @beats = @beats.key(params[:key]) if params[:key].present?
      @beats = @beats.tagged_with(params[:tagged_with]) if params[:tagged_with].present?
    
      format.html 
      format.js { render 'beats/filter.js.erb'}
    end
  end

  def show
    @beat = Beat.friendly.find(params[:id])
    @stems = @beat.stems.all
  end

  def new
    @beat = Beat.new
  end

  def create
    @user = current_user
    @beat = @user.beats.new(beat_params)
    @beat.tag_list = params[:beat][:tag_list].join(',')
    if @beat.save
      redirect_to :beats, notice: "Beat was successfully created."
    else
      redirect_to :beats, alert: "Beat couldn't be created! #{@beat.errors.full_messages}"
    end
  end

  def edit
    @beat = Beat.friendly.find(params[:id])
    redirect_to :root unless @beat.user == current_user
    @stems = @beat.stems.all
  end

  def update
    @beat = Beat.friendly.find(params[:id])
    redirect_to :root unless @beat.user == current_user
    @beat.tag_list = params[:beat][:tag_list]
    if @beat.update(beat_params)
      redirect_to :beats, notice: "Beat was successfully updated."
    else
      redirect_to :beats, notice: "Beat was successfully updated."
    end
  end

  def destroy
    @beat = Beat.friendly.find(params[:id])
    redirect_to :root unless @beat.user == current_user
    if @beat.destroy
      redirect_to :beats, notice: "Beat was successfully removed."
    else
      redirect_to :beats, alert: "Beat couldn't be removed!"
    end
  end

  private
  def beat_params
    params.require(:beat).permit(:name, :bpm, :key, :link)
  end

  def beat_liked_by_user(beat)
    Like.where(user_id: current_user.id, beat_id: beat.id).exists?
  end
end
