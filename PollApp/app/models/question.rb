# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  question   :text             not null
#  poll_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def n_plus_one_results
    answer_choices = self.answer_choices
    answers = {}
    answer_choices.each do |ac|
      answers[ac] = ac.responses.count
    end
    answers
  end

  def includes_results
    answer_choices = self.answer_choices.includes(:responses)
    answers = {}
    answer_choices.each do |ac|
      answers[ac] = ac.responses.count
    end
    answers
  end

  def best_results
    res = {}
    answer_choices = self.answer_choices
      .joins(:responses)
      .group("answer_choices.id")
      .select("answer_choices.*, COUNT(responses.id) AS response_count")
    answer_choices.each do |ac|
      res[ac] = ac.response_count
    end
    res
  end

end
