require 'rails_helper'

describe 'Items API' do
  it '#index' do

    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get '/api/v1/items'

    items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(items[:data].count).to eq(3)

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

  it '#show' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id).id

    get "/api/v1/items/#{item}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_a(String)

    expect(item[:data]).to have_key(:type)
    expect(item[:data][:type]).to eq('item')

    expect(item[:data]).to have_key(:attributes)
    expect(item[:data][:attributes]).to be_a(Hash)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
  end

  it '#create' do
    id = create(:merchant).id
    item_params = ({
                    name: 'Guitar',
                    description: 'Fender brand electric guitar.',
                    unit_price: 400.99,
                    merchant_id: id
    })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq('Guitar')
    expect(created_item.description).to eq('Fender brand electric guitar.')
    expect(created_item.unit_price).to eq(400.99)
    expect(created_item.merchant_id).to be_a(Integer)
  end

  it '#update' do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id
    previous_item = Item.last.name
    item_params = { name: "Gibson" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_item)
    expect(item.name).to eq("Gibson")
  end

  it '#destroy' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  describe '#sad_path' do
    it 'reponds with a 404 code when bad id is given' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/505050"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
    end

    it 'reponds with a 404 code when string id is given' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/'494949'"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
    end

    it 'reponds with a 404 code when updating with bad merchant id' do
      merchant = create(:merchant)
      id = create(:item, merchant_id: merchant.id).id

      item_params = { name: "Gibson", merchant_id: 50505050 }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
    end
  end
end