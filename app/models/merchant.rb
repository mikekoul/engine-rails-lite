class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items

  def self.search_merchant(name)
    where("name ILIKE ?", "%#{name}%").order(name: :asc).first
  end
end