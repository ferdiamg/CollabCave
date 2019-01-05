class Beat < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  validates :name, length: { minimum: 3, maximum: 25 }
  validates :bpm, format: { with: /\A\d+\z/ }, length: { maximum: 3 }
  validates :key, length: { minimum: 1, maximum: 3 }
  validates :link, presence: true, format: { with: /.(mp3|ogg|wav)\z/}

  scope :from_bpm, -> (bpm) { where("bpm >= ?", "#{bpm}") }
  scope :to_bpm, -> (bpm) { where("bpm <= ?", "#{bpm}") }
  scope :key, -> (key) { where key: key }

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :artists

  has_many :likes, dependent: :destroy
  has_many :stems, dependent: :destroy
  belongs_to :user

  def slug_candidates
    [
      [:name, :bpm, :key]
    ]
  end
end
