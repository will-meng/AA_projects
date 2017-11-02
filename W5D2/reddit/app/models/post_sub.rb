# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  sub_id     :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostSub < ApplicationRecord
  validates :sub, :post, presence: true
  validates :post_id, uniqueness: { scope: :sub_id }

  belongs_to :sub, optional: true
  belongs_to :post, optional: true
end
