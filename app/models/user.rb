class User < ApplicationRecord
  authenticates_with_sorcery!
  extend FriendlyId
  friendly_id :username, use: :slugged

  validates :password, presence: true, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true, length: { minimum: 5, maximum: 30 }
  validates :username, uniqueness: true, length: { minimum: 3, maximum: 20 }, format: { with: /\A[a-zA-Z0-9-_]+\z/}

  has_many :beats, dependent: :destroy
  has_many :likes, dependent: :destroy
  # has_many :collaboration_requests, -> {where(collaborator_id: self.id)}
  has_many :incoming_collaboration_requests, foreign_key: "producer_id", class_name: "CollaborationRequest"
  has_many :outgoing_collaboration_requests, foreign_key: "collaborator_id", class_name: "CollaborationRequest"
end
