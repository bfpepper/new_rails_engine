class Api::V1::Items::SearchController < ApplicationController

  def index
      render json: Item.where(filter)
  end

  def filter
    filter = {}
    filter[:unit_price] = (params[:unit_price].to_f * 100).round.to_s if params[:unit_price]
    filter.merge!(items_params.to_h)
  end

  def show
    render json: Item.where(filter).order(:id).first
  end

  def random
    offset = rand(Item.count)
    render json: Item.offset(offset).first
  end

  private

  def items_params
    params.permit(:name,
                  :id,
                  :created_at,
                  :updated_at,
                  :unit_price,
                  :description,
                  :merchant_id)
  end

end
