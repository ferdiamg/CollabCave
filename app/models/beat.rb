class Beat < ApplicationRecord
  validates :name, length: { minimum: 3, maximum: 15 }
  validates :bpm, format: { with: /\A\d+\z/ }, length: { maximum: 3 }
  validates :key, length: { maximum: 3 }
  validates :link, presence: true

  has_many :artists
  belongs_to :user

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :artists
end
