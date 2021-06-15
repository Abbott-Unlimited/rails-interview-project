# frozen_string_literal: true

# User
class User < ApplicationRecord
  has_many :questions, inverse_of: :user
  has_many :answers,   inverse_of: :user
end
