# frozen_string_literal: true

# Initial migration for Questions
class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title, null: false, index: true
      t.boolean :private, default: false, index: true
      t.references :user, null: false

      t.timestamps null: false
    end
  end
end
