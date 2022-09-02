require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'
    
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchants[:data].count).to eq(3)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_a(String)
      expect(merchant[:type]).to eq('merchant')

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'can return one merchant by an id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)

    expect(merchant[:data]).to have_key(:type)
    expect(merchant[:data][:type]).to be_a(String)

    expect(merchant[:data]).to have_key(:attributes)
    expect(merchant[:data][:attributes]).to be_a(Hash)
    
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  describe '#sad_path' do
    it 'reponds with a 404 code when bad id is given' do
      create(:merchant).id

      get "/api/v1/merchants/505050"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
    end

    it 'reponds with a 404 code when bad id is given' do
      create(:merchant).id

      get "/api/v1/merchants/'505050'"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
    end
  end
end