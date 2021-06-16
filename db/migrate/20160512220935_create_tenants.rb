# frozen_string_literal: true

# Initial migration for Tenants
class CreateTenants < ActiveRecord::Migration[6.1]
  def change
    create_table :tenants do |t|
      t.string :name, null: false
      t.string :api_key, null: false, index: true
      t.integer :calls_today, null: false, default: 0
      t.integer :calls_lifetime, null: false, default: 0
      t.datetime :last_call

      t.timestamps null: false
    end
  end
end
