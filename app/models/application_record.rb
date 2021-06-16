# frozen_string_literal: true

# Base Active Record class
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
