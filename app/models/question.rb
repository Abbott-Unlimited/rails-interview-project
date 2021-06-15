# frozen_string_literal: true

# Question asked by a user
class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user

  # Questions, answers, and users
  # @param include_private [Boolean]
  # @param search [String] queries the questions for a search term
  # @return [Hash]
  def self.q_and_a(include_private: false, search: nil)
    # Iterate through each question that matches the criteria
    # @todo should use a serializer in the real world
    # @todo should page questions in real world
    joins(:user)
      .select(:id, :title, 'users.name AS user')
      .where(include_private ? nil : { private: false })
      .where(search.present? ? "questions.title LIKE '%#{search}%'" : nil)
      .order(:id)
      .map do |question|
      question.attributes.merge('answers' => question.answers_with_users.map(&:attributes))
    end
  end

  # Answers for this question with the user association
  # @return [Answer::ActiveRecord_Relation]
  def answers_with_users
    answers.joins(:user).select(:id, :body, 'users.name as user').order(:id)
  end
end
