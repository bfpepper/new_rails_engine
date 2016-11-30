class Api::V1::Items::SearchController < ApplicationController

  def index
    render json: Item.where(items_params)
  end

  def show
    render json: Item.find_by(items_params)
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
