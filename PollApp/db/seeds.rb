# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

zach = User.create!(user_name: "zach")

moktar = User.create!(user_name: "moktar")

bill = User.create!(user_name: "bill")

mike = User.create!(user_name: "mike")

zach_poll = Poll.create!(title: "Zach's Day Poll", author_id: 1)

question1 = Question.create!(question: "Is today Thursday?", poll_id: 1)

true_day = AnswerChoice.create!(answer_choice: "true", question_id: 1)

false_day = AnswerChoice.create!(answer_choice: "false", question_id: 1)

moktar_response = Response.create!(user_id: 2, answer_choice_id: 1)

bill_response = Response.create!(user_id: 3, answer_choice_id: 2)

mike_response = Response.create!(user_id: 4, answer_choice_id: 1)
