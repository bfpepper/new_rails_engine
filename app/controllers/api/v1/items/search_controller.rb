class Api::V1::Items::SearchController < ApplicationController

  def show
    render json: Item.find_by(items_params)
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
