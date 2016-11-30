require 'rails_helper'

RSpec.describe Merchant, type: :model do

  context "Relationships" do
    it { should have_many(:invoices) }
    it { should have_many(:items) }
    it { should have_many(:customers) }
  end
end


# context "Validations" do
#   it { should validate_presence_of(:name) }
# end
