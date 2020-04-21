# frozen_string_literal: true

class Product < ApplicationRecord
  enum status_values: { missing: 0, found: 1 }
  validates :venue_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :venue_id }
  validates :status, presence: true, inclusion: { in: status_values.values }

  scope :filter_by_status, ->(status) { where status: status }
  scope :filter_by_venue_id, ->(venue_id) { where venue_id: venue_id }
  scope :filter_by_name, ->(name) { where name: name }

  def self.filter(params)
    products = Product.all
    params.slice(:status, :name, :venue_id).each do |k, v|
      products = products.public_send("filter_by_#{k}", v) if v.present?
    end

    products
  end
end
