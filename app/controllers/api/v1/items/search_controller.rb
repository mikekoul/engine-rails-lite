class Api::V1::Items::SearchController < ApplicationController 
  before_action :param_validation

  def find_items
    items = Item.search_items(params[:name])
    if items.nil?
      render json: { data: [] }
    else
      render json: ItemSerializer.new(items)
    end
  end

  private
  def param_validation
    if !params[:name].present?
      render json: { data: {} }, status: 400
    end
  end
end