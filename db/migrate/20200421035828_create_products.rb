# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :status, default: 0
      t.string :venue_id
      t.string :shelf

      t.timestamps
    end
  end
end
