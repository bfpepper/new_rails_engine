class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    render json: Merchant.find(params[:merchant_id])
      .invoices
      .joins(:transactions)
      .where.not(transactions: {result: "failed"})
      .joins(:invoice_items)
      .sum("quantity * unit_price")
  end

end
