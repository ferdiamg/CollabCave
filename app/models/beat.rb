class Beat < ApplicationRecord
  validates :name, length: { minimum: 3, maximum: 15 }
  validates :bpm, length: { maximum: 3 }
  validates :key, length: { maximum: 3 }
  validates :link, presence: true

  has_many :artists
  belongs_to :user
end
