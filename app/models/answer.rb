# frozen_string_literal: true

# Answer given by a user
class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
end
