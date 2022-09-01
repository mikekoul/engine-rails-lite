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
    it 'returns a merchant with a case-insensitive and fragmented name search' do
      merchant_1 = Merchant.create!(name: 'Little Shop of Horrors')
      merchant_2 = Merchant.create!(name: 'Strange Imports')
      merchant_3 = Merchant.create!(name: 'Jewelery Rangers')

      expect(Merchant.search_merchant("LiTTle")).to eq(merchant_1)
      expect(Merchant.search_merchant("rang")).to eq(merchant_3)
      expect(Merchant.search_merchant("imp")).to eq(merchant_2)
    end
  end
end