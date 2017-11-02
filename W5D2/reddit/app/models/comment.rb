# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :text             not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :author, class_name: :User
  belongs_to :post

  belongs_to :parent_comment, class_name: :Comment, optional: true
  has_many :child_comments, foreign_key: :parent_comment_id, class_name: :Comment

  has_many :votes, as: :votable
end
