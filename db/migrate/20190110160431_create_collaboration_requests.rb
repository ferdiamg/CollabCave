class CreateCollaborationRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :collaboration_requests do |t|
      t.references :beat
      t.references :collaborator
      t.references :producer

      t.timestamps
    end
  end
end
