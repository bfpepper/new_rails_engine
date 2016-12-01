class Api::V1::InvoiceItems::SearchController < ApplicationController

  def index
    render json: InvoiceItem.where(filter)
  end

  def filter
    filter = {}
    filter[:unit_price] = (params[:unit_price].to_f * 100).round.to_s if params[:unit_price]
    filter.merge!(invoice_items_params.to_h)
  end

  def show
    render json: InvoiceItem.find_by(filter)
  end

  def random
    render json: InvoiceItem.offset(rand(InvoiceItem.count)).first
  end

  private

  def invoice_items_params
    params.permit(:id,
                  :item_id,
                  :invoice_id,
                  :quantity,
                  :unit_price,
                  :created_at,
                  :updated_at)
  end

end
