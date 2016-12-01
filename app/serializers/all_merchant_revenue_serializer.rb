class AllMerchantRevenueSerializer < ActiveModel::Serializer
  attributes :total_revenue

  def total_revenue
    (object / 100).to_s
  end
end
