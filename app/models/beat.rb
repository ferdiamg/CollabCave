class Beat < ApplicationRecord
  validates :name, length: { minimum: 3, maximum: 15 }
  validates :bpm, format: { with: /\A\d+\z/ }, length: { maximum: 3 }
  validates :key, length: { maximum: 3 }
  validates :link, presence: true, format: { with: /.(mp3|ogg|wav)\z/}

  scope :from_bpm, -> (bpm) { where("bpm >= ?", "#{bpm}") }
  scope :to_bpm, -> (bpm) { where("bpm <= ?", "#{bpm}") }
  scope :key, -> (key) { where key: key }

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :artists

  has_many :artists
  has_many :likes, dependent: :destroy
  has_many :stems, dependent: :destroy
  belongs_to :user
end
