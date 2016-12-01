class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Merchant.all_revenue(params[:date])
  end

  def show
    render json: Merchant.find(params[:merchant_id]).total_revenue(params[:date])
  end

end
