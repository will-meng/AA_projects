class Album < ApplicationRecord
  validates :title, :year, :band_id, presence: true
  belongs_to :band
  has_many :tracks, dependent: :destroy
end
