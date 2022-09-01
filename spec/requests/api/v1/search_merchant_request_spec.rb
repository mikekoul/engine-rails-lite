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

  it 'returns error message when no merchant is found' do
    merchant_1 = Merchant.create!(name: 'Little Shop of Horrors')

    get '/api/v1/merchants/find?name=ing'

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data][:message]).to eq('Merchant not found')
  end
end