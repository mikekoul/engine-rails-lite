class Customer < ApplicationRecord
  validates_presence_of :first_name, presence: true
  validates_presence_of :last_name, presence: true

  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :merchants, through: :invoices
end