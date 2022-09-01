require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#validations' do
    it { validate_presence_of :name }
    it { validate_presence_of :description }
    it { validate_presence_of :unit_price }
    it { validate_presence_of :merchant_id }
  end

  describe '#relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe '#class methods' do
    it 'returns all items that match a case-insensitive and fragmented name search' do
      merchant_1 = Merchant.create!(name: 'Little Shop of Horrors')
      item_1 = Item.create!(name: 'Plant food', description: 'Food for plants', unit_price: 10.00, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: 'Plant Pot', description: 'Pot for plants', unit_price: 20.00, merchant_id: merchant_1.id)
      item_3 = Item.create!(name: 'Venus Fly Trap', description: 'Venus Fly Trap plant', unit_price: 30.00, merchant_id: merchant_1.id)

      expect(Item.search_items("lanT")).to eq([item_1, item_2])
      expect(Item.search_items("ven")).to eq([item_3])
    end
  end
end