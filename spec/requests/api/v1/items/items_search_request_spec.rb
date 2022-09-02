require 'rails_helper'

describe 'Item find all API' do
  it 'returns all items that match a case-insensitive and fragmented name search' do
    merchant_1 = Merchant.create!(name: 'Little Shop of Horrors')
    item_1 = Item.create!(name: 'Plant food', description: 'Food for plants', unit_price: 10.00, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: 'Plant Pot', description: 'Pot for plants', unit_price: 20.00, merchant_id: merchant_1.id)
    item_3 = Item.create!(name: 'Venus Fly Trap', description: 'Venus Fly Trap plant', unit_price: 30.00, merchant_id: merchant_1.id)

    get '/api/v1/items/find_all?name=LanT'

    items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(items[:data].count).to eq(2)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)
      expect(item[:type]).to eq('item')

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  describe '#sad_path' do
    it 'returns error message when no items are found' do
      merchant_1 = Merchant.create!(name: 'Little Shop of Horrors')
      item_1 = Item.create!(name: 'Plant food', description: 'Food for plants', unit_price: 10.00, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: 'Plant Pot', description: 'Pot for plants', unit_price: 20.00, merchant_id: merchant_1.id)
      item_3 = Item.create!(name: 'Venus Fly Trap', description: 'Venus Fly Trap plant', unit_price: 30.00, merchant_id: merchant_1.id)

      get '/api/v1/items/find_all?name=Ing'

      items = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful

      expect(items[:data].count).to eq(0)
    end

    it 'returns error message when search param is given' do
      merchant_1 = Merchant.create!(name: 'Little Shop of Horrors')
      item_1 = Item.create!(name: 'Plant food', description: 'Food for plants', unit_price: 10.00, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: 'Plant Pot', description: 'Pot for plants', unit_price: 20.00, merchant_id: merchant_1.id)
      item_3 = Item.create!(name: 'Venus Fly Trap', description: 'Venus Fly Trap plant', unit_price: 30.00, merchant_id: merchant_1.id)

      get '/api/v1/items/find_all?name='

      items = JSON.parse(response.body, symbolize_names: true)
   
      expect(response).to_not be_successful

      expect(response.status).to eq(400)
    end
  end

  describe '#param_validation' do
    it 'returns status 400 if no name paramter is provided' do
      merchant_1 = Merchant.create!(name: 'Little Shop of Horrors')
      item_1 = Item.create!(name: 'Plant food', description: 'Food for plants', unit_price: 10.00, merchant_id: merchant_1.id)

      get '/api/v1/items/find_all'

      expect(response).to_not be_successful

      expect(response.status).to eq(400)
    end
  end
end