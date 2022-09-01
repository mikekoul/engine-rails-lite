class Api::V1::SearchesController < ApplicationController
  
  def find_merchant
    merchant = Merchant.search_merchant(params[:name])
    if merchant.nil?
      render json: { data: { message: 'Merchant not found'} }
    else
      render json: MerchantSerializer.new(merchant)
    end
  end
end