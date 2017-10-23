class Question < ApplicationRecord
  validates :text, presence: true

  belongs_to :poll
  has_many :answer_choices

  has_many :responses, through: :answer_choices

  def results
    count = Hash.new(0)

    # choices = answer_choices.includes(:responses)
    choices = answer_choices.left_outer_joins(:responses).group(:id)
      .select('answer_choices.*, COUNT(responses.answer_choice_id) AS count_all')
    choices.each do |choice|
      # count[choice.text] = choice.responses.length
      count[choice.text] = choice.count_all
    end
    count
  end
end
