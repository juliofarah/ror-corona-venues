# frozen_string_literal: true

class Product < ApplicationRecord
  enum status_values: { missing: 0, found: 1 }
  validates :venue_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :venue_id }

  validates :status, presence: true, inclusion: { in: status_values.values }
end
