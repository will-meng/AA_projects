class Vote < ApplicationRecord
  validates :value, presence: true
  belongs_to :nameable, polymorphic: true
end
