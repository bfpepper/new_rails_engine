class Api::V1::Items::SearchController < ApplicationController

  def index
    if items_params[:unit_price]
      render json: Item.where(unit_price: items_params[:unit_price].to_f * 100)
    else
      render json: Item.where(items_params)
    end
  end

  def show
    if items_params[:unit_price]
      render json: Item.find_by(unit_price: (params[:unit_price].to_f * 100).round.to_s)
    else
      render json: Item.find_by(items_params)
    end
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
