# frozen_string_literal: true

class VenuesController < ApplicationController
  include HTTParty
  before_action :set_venue, only: %i[show update destroy]

  # GET /venues
  def index
    cached = Rails.cache.read('location:vancouver')
    if cached
      # TODO: increase successful cache hit stats
      Rails.logger.info 'cache hit'
      render json: cached
    else
      # TODO: increase missed cache hit stats
      # TODO increase API hits
      Rails.logger.info 'cache miss'
      api_response = HTTParty.get('https://api.foursquare.com/v2/venues/explore', {
                                    query: {
                                      client_id: ENV['CLIENT_ID'],
                                      client_secret: ENV['CLIENT_SECRET'],
                                      query: 'groceries',
                                      near: 'Vancouver',
                                      v: '20180323',
                                      limit: 1
                                    }
                                  })

      res = api_response['response']['groups'].map { |g| g['items'] }
      Rails.cache.write('location:vancouver', res)

      render json: res
    end
  end

  # GET /venues/1
  def show
    render json: @venue
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_venue
    @venue = Venue.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def venue_params
    params.fetch(:venue, {})
  end
end
