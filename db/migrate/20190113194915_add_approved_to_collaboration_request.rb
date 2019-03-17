class AddApprovedToCollaborationRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :collaboration_requests, :approved, :boolean, :default => false
  end
end
