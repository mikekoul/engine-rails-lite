require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe '#validations' do
    it { validate_presence_of :name }
  end

  describe '#relationships' do
    it { should have_many :items}
  end

  describe '#class methods' do
    it 'returns a merchant when a name is searched for' do
      merchant_1 = Merchant.create!(name: 'Little Shop of Horrors')
      merchant_2 = Merchant.create!(name: 'Strange Imports')
      merchant_3 = Merchant.create!(name: 'Jewelery Rangers')

      expect(Merchant.search_merchant("LiTTle")).to eq(merchant_1)
      expect(Merchant.search_merchant("rang")).to eq(merchant_3)
      expect(Merchant.search_merchant("imp")).to eq(merchant_2)
    end
  end
end