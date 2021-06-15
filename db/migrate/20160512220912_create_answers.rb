# frozen_string_literal: true

# Initial migration for Answers
class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.string :body, null: false
      t.references :question, null: false, index: true
      t.references :user, null: false, index: true

      t.timestamps null: false
    end
  end
end
