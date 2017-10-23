class Response < ApplicationRecord
  validate :not_duplicate_response
  validate :not_author_response

  belongs_to :answer_choice
  belongs_to :respondent, class_name: :User

  has_one :question, through: :answer_choice

  private

  def sibling_responses
    question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(respondent_id: self.respondent_id)
  end

  def respondent_is_author?
    question.poll.author.id == respondent_id
  end

  def not_duplicate_response
    if respondent_already_answered?
      errors[:respondent_id] << 'Cannot answer same question more than once'
    end
  end

  def not_author_response
    if respondent_is_author?
      errors[:respondent_id] << 'Author cannot answer own question'
    end
  end
end
