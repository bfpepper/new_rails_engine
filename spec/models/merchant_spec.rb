require 'rails_helper'

RSpec.describe Merchant, type: :model do
  context "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  context "Relationships" do
    it { should have_many(:invoices) }
    it { should have_many(:items) }
  end
end
