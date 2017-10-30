class Track < ApplicationRecord
  validates :title, :album_id, :ord, presence: true
  validates :ord, uniqueness: { scope: :album_id }

  belongs_to :album
  has_many :notes, dependent: :destroy
end
