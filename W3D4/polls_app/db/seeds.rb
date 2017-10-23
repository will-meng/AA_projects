# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create(username: :William)
u2 = User.create(username: :BobRoss)
u3 = User.create(username: :WiseOldMan)

p1 = Poll.create(title: 'On the crucial aspects of human beings',
                 author_id: u1.id)

q1 = Question.create(text: 'Why does the President lie all the time?',
                     poll_id: p1.id)
q2 = Question.create(text: 'What is the meaning of life?', poll_id: p1.id)

a1a = AnswerChoice.create(text: "He can't help it", question_id: q1.id)
a1b = AnswerChoice.create(text: "He doesn't realize it", question_id: q1.id)
a1c = AnswerChoice.create(text: "His ego is huuuuge", question_id: q1.id)

a2a = AnswerChoice.create(text: "42", question_id: q2.id)
a2b = AnswerChoice.create(text: "God", question_id: q2.id)
a2c = AnswerChoice.create(text: "To further our understanding of the universe",
                          question_id: q2.id)
a2d = AnswerChoice.create(text: "To love and respect all life", question_id: q2.id)

Response.create(answer_choice_id: a1a.id, respondent_id: u2.id)
Response.create(answer_choice_id: a2c.id, respondent_id: u2.id)
Response.create(answer_choice_id: a1c.id, respondent_id: u3.id)
Response.create(answer_choice_id: a2d.id, respondent_id: u3.id)
