# frozen_string_literal: true

class VenuesController < ApplicationController
  include HTTParty

  # GET /venues
  def index
    fetch_by_location(params['location'])
  end

  private

  def fetch_by_location(location)
    cached = Rails.cache.read("location:#{location}")
    unless cached.nil?
      # TODO: increase successful cache hit stats
      Rails.logger.info 'cache hit'
      cached
    end

    fetch_from_remote(location)
  end

  def fetch_from_remote(location)
    # TODO: increase missed cache hit stats
    # TODO: increase API hits
    Rails.logger.info 'cache miss'
    api_response = HTTParty.get(
      'https://api.foursquare.com/v2/venues/explore', {
        query: {
          client_id: ENV['CLIENT_ID'],
          client_secret: ENV['CLIENT_SECRET'],
          query: 'groceries',
          near: location,
          v: '20180323',
          limit: 1
        }
      }
    )
    res = api_response['response']['groups'].map { |g| g['items'] }
    # TODO: increase cache writes stats

    Rails.cache.write('location:vancouver', res)
    res
  end
end
