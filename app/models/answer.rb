# frozen_string_literal: true

# Answer given by a user
class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
end
