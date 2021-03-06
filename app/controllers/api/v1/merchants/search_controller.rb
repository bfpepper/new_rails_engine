class Api::V1::Merchants::SearchController < ApplicationController

  def index
    render json: Merchant.where(merchant_params)
  end

  def show
    render json: Merchant.find_by(merchant_params)
  end

  def random
    render json: Merchant.offset(rand(Merchant.count)).first
  end

  private

  def merchant_params
    params.permit(:name, :id, :created_at, :updated_at)
  end

end
