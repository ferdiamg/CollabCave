class Beat < ApplicationRecord
  validates :name, length: { minimum: 3, maximum: 15 }
  validates :bpm, format: { with: /\A\d+\z/ }, length: { maximum: 3 }
  validates :key, length: { maximum: 3 }
  validates :link, presence: true

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :artists

  has_many :artists
  has_many :likes, dependent: :destroy
  belongs_to :user

  private
    def self.filtered_by_bpm(bpm)
      self.where("bpm >= ?", bpm)
    end

    def self.filtered_by_key(key)
      self.where("key == ?", key)
    end

    def self.filtered_by_tags(tag_array)
      self.tagged_with(tag_array, any: true)
    end
end
