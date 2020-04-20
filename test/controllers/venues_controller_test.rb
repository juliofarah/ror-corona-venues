# frozen_string_literal: true

require 'test_helper'

class VenuesControllerTest < ActionDispatch::IntegrationTest
  @memory_store = ActiveSupport::Cache.lookup_store(:memory_store)
  @httparty = HTTParty

  setup do
    allow(Rails).to receive(:cache).and_return(memory_store)
    Rails.cache.clear
  end

  test '#index fetches from cache' do
    allow(Rails.cache).to receive(:read).with('location:vancouver').and_return(nil)
    allow(@httparty).to receive(:get).and_return([])
    allow(Rails.cache).to receive(:write).with('location:vancouver', [])

    get venues_url, as: :json
  end
end
