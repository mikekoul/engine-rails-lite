require 'rails_helper'

describe 'Merchant find API' do
  it 'returns merchant with a case-insensitive and fragmented name search' do
    merchant_1 = Merchant.create!(name: 'Little Shop of Horrors')
    merchant_2 = Merchant.create!(name: 'Strange Imports')
    merchant_3 = Merchant.create!(name: 'Jewelery Rangers')

    get '/api/v1/merchants/find?name=rAng'

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)

    expect(merchant[:data]).to have_key(:type)
    expect(merchant[:data][:type]).to be_a(String)

    expect(merchant[:data]).to have_key(:attributes)
    expect(merchant[:data][:attributes]).to be_a(Hash)
    
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to eq('Jewelery Rangers')
  end

  describe '#sad_path' do
    it 'returns error message when no merchant is found' do
      merchant_1 = Merchant.create!(name: 'Little Shop of Horrors')

      get '/api/v1/merchants/find?name=ing'

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(merchant[:data][:message]).to eq('Merchant not found')
    end

    it 'returns error message when no name param is given found' do
      merchant_1 = Merchant.create!(name: 'Little Shop of Horrors')

      get '/api/v1/merchants/find?name='

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful

      expect(response.status).to eq(400)
    end
  end

  describe '#param_validation' do
    it 'returns status 400 if no name paramter is provided' do
      merchant_1 = Merchant.create!(name: 'Little Shop of Horrors')

      get '/api/v1/merchants/find'

      expect(response).to_not be_successful

      expect(response.status).to eq(400)
    end
  end
end