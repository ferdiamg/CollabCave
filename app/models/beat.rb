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

  def self.search(params)
    if params[:filter].present?
      beats = Beat.all.page(params[:page]).per(500)
    else
      beats = Beat.all.page(params[:page]).per(10)
    end
    beats = beats.from_bpm(params[:from_bpm]) if params[:from_bpm].present?
    beats = beats.to_bpm(params[:to_bpm]) if params[:to_bpm].present?
    beats = beats.key(params[:key]) if params[:key].present?
    beats = beats.tagged_with(params[:tagged_with]) if params[:tagged_with].present?
    beats
  end
end
