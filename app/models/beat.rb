class Beat < ApplicationRecord
  has_many :artists
  belongs_to :user
end
