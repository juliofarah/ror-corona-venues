class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :update, :destroy]

  # GET /venues
  def index
    @venues = File.read("db/venues.json")
    logger.info @venues
    render json: @venues
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
