# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VenuesController, type: :controller do
  let(:parsed_venues) do
    [
      [
        {
          'reasons' => {
            'count' => 0,
            'items' => [
              {
                'reasonName' => 'globalInteractionReason',
                'summary' => 'This spot is popular',
                'type' => 'general'
              }
            ]
          },
          'referralId' => 'e-0-4aa81b5cf964a5205c4f20e3-0',
          'venue' => {
            'categories' => [
              {
                'icon' => {
                  'prefix' =>
                 'https://ss3.4sqi.net/img/categories_v2/shops/food_grocery_',
                  'suffix' => '.png'
                },
                'id' => '4bf58dd8d48988d118951735',
                'name' => 'Grocery Store',
                'pluralName' => 'Grocery Stores',
                'primary' => true,
                'shortName' => 'Grocery Store'
              }
            ],
            'id' => '4aa81b5cf964a5205c4f20e3',
            'location' => {
              'address' => '1595 Kingsway',
              'cc' => 'CA',
              'city' => 'Vancouver',
              'country' => 'Canada',
              'crossStreet' => 'Perry St',
              'formattedAddress' => [
                '1595 Kingsway (Perry St)', 'Vancouver BC V5N 2R8', 'Canada'
              ],
              'labeledLatLngs' => [
                {
                  'label' => 'display',
                  'lat' => 49.24835555505501,
                  'lng' => -123.07147057968633
                }
              ],
              'lat' => 49.24835555505501,
              'lng' => -123.07147057968633,
              'postalCode' => 'V5N 2R8',
              'state' => 'BC'
            },
            'name' => 'Famous Foods'
          }
        }
      ]
    ]
  end

  context 'foo' do
    it '#index fetches from cache' do
      venues_response = File.read('spec/fixtures/venues.json')
      venues = JSON.parse(venues_response)

      allow(Rails.cache).to receive(:read).with('location:vancouver').and_return(nil)
      allow(HTTParty).to receive(:get).and_return(venues)
      allow(Rails.cache).to receive(:write).with('location:vancouver', parsed_venues)

      get :index, params: { location: 'vancouver' }, as: :json
      expect(JSON.parse(response.body)).to eq(parsed_venues)
    end
  end
end
