class CatRentalRequest < ApplicationRecord
STATUSES = %w[APPROVED PENDING DENIED]

validates :status, inclusion: { in: STATUSES, message: "Invalid Status"}
validates :cat_id, :start_date, :end_date, presence: true
validate :does_not_overlap_approved_request

belongs_to :cat,
  primary_key: :id,
  foreign_key: :cat_id,
  class_name: :Cat


def overlapping_requests
  CatRentalRequest.joins(:cat)
    .where(cats: {id: cat_id })
    .where('(? BETWEEN start_date AND end_date) OR
            (? BETWEEN start_date AND end_date)', start_date, end_date)
end

def overlapping_approved_requests
  overlapping_requests.where(status: STATUSES.first)
end

def does_not_overlap_approved_request
  unless overlapping_approved_requests.empty?
    errors[:base] << 'Dates overlap. Bad. Not good.'
    return false
  end
  true
end

def approve!
  if status == 'PENDING'
    status = 'APPROVED'
    if self.save
      results = CatRentalRequest.where(cat_id: cat_id).where.not(id: id)
      results.each do |result|
        result.status = 'DENIED' unless result.does_not_overlap_approved_request
      end
    end
  end
end



end
