# frozen_string_literal: true

class AddUniquenessIndexToProducts < ActiveRecord::Migration[6.0]
  def change
    add_index :products, %i[name venue_id], unique: true
  end
end
