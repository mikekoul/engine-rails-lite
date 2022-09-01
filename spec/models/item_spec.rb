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
end