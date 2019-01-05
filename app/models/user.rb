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
end
