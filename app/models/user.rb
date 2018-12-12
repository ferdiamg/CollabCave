class User < ApplicationRecord
  authenticates_with_sorcery!
  extend FriendlyId
  friendly_id :username, use: :slugged

  validates :password, presence: true, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true
  validates :username, uniqueness: true

  has_many :beats, dependent: :destroy
  has_many :likes, dependent: :destroy
end
