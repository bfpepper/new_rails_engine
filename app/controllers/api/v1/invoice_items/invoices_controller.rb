class Api::V1::InvoiceItems::InvoicesController < ApplicationController

  def index
    render json: InvoiceItem.find(params[:invoice_item_id]).invoice
  end

end
