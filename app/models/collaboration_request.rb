class CollaborationRequest < ApplicationRecord
  belongs_to :producer, class_name: "User"
  belongs_to :collaborator, class_name: "User"
  belongs_to :beat
end