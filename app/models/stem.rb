class Stem < ApplicationRecord
  validates :name, length: { minimum: 3, maximum: 15 }
  validates :link, presence: true

  belongs_to :beat
end
