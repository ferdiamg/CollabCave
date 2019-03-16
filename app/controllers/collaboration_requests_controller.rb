class CollaborationRequestsController < ApplicationController

  def index
    @incoming_collabs = current_user.incoming_collaboration_requests
    @outgoing_collabs = current_user.outgoing_collaboration_requests
    @allcollabs = @incoming_collabs + @outgoing_collabs
  end

  def new
    @collab = CollaborationRequest.new
  end

  def create
    @collab = CollaborationRequest.new(collaboration_request_create_params)
    if current_user.beats.find_by_id(@collab.beat_id)
      redirect_to Beat.find(@collab.beat_id), alert: "Can't request collaborations on your own beats!"
    else
      if current_user.outgoing_collaboration_requests.exists?(beat_id: @collab.beat_id)
        redirect_to Beat.find(@collab.beat_id), alert: "Can't request a collaboration on a beat twice!"
      else
        if @collab.save
          redirect_to Beat.find(@collab.beat_id), notice: "Asked #{@collab.producer.username} for a collaboration!"
        else
          redirect_to Beat.find(@collab.beat_id), alert: "#{@collab.errors.full_messages}"
        end
      end
    end
  end

  def update
    @collab = current_user.incoming_collaboration_requests.find(params[:id])
    if @collab.approved == true
      redirect_to :collaborations, alert: "Can't approve twice!"
    else
      if @collab.update(approved: true)
        redirect_to :collaborations, notice: "Approved collaboration request!"
      else
        redirect_to :collaborations, alert: "Couldn't approve collaboration request!"
      end
    end
  end

  def destroy
    @collab = if params[:outgoing] then current_user.outgoing_collaboration_requests.find_by_id(params[:id]) else current_user.incoming_collaboration_requests.find_by_id(params[:id]) end
    if @collab != nil
      if @collab.destroy
        redirect_to :collaborations, notice: "Deleted collaboration request!"
      else
        redirect_to :collaborations, alert: "Couldn't delete collaboration request!"
      end
    else
      redirect_to :collaborations, notice: "Collaboration already deleted!"
    end
    
  end

  private
  def collaboration_request_create_params
    params.permit(:collaborator_id, :producer_id, :beat_id)
  end

  def collaboration_request_params
    params.require(:collaboration_request).permit(:approved, :producer_id, :collaborator_id)
  end
end