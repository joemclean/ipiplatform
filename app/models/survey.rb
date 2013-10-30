class Survey < ActiveRecord::Base
  has_many :questions
  attr_accessor :answers

  def score
    answer_ids = strip_ids(@answers)
    survey_score = count_colors(answer_ids)
    sort_results(survey_score)
  end

  def strip_ids(answers)
    selected_color_ids = []
    answers.each do |question_number, color_id|
      selected_color_ids << color_id.to_i
    end
    selected_color_ids
  end

  def count_colors (selected_color_ids)
    color_count = {}
    Color.ids.each do |color_id|
      selected_color_count = selected_color_ids.count(color_id)
      color_count[color_id] = selected_color_count
    end
    color_count
  end

  def sort_results(survey_score)
    survey_score.sort_by{|color_id, count| count}.reverse.first(5)
  end

  def generate_questions
    value_propositions = ValueProposition.all
    value_propositions.each do |value_proposition|
      question_number = 0
      5.times do
        question = self.questions.build
        value_proposition.colors.each do |color|
          question.question_responses << color.question_responses.fetch(question_number)
        end
        question_number += 1
      end
    end
  end
end
