class Api::V1::SearchesController < ApplicationController
  before_action :param_validation

  def find_merchant
    merchant = Merchant.search_merchant(params[:name])
    if merchant.nil?
      render json: { data: { message: 'Merchant not found' } }
    else
      render json: MerchantSerializer.new(merchant)
    end
  end

  private
  def param_validation
    if !params[:name].present?
      render json: { data: {} }, status: 400
    end
  end
end