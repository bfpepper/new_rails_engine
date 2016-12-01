class Api::V1::InvoiceItems::SearchController < ApplicationController

  def index
    if invoice_items_params[:unit_price]
      render json: InvoiceItem.where(unit_price: invoice_items_params[:unit_price].to_f*100)
    else
      render json: InvoiceItem.where(invoice_items_params)
    end
  end

  def show
    if invoice_items_params[:unit_price]
      render json: InvoiceItem.find_by(unit_price: (params[:unit_price].to_f * 100).round.to_s)
    else
      render json:InvoiceItem.find_by(invoice_items_params)
    end
  end

  def random
    offset = rand(InvoiceItem.count)
    render json: InvoiceItem.offset(offset).first
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
