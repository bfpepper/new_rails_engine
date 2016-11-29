require 'rails_helper'

describe "merchants endpoints" do
  context "GET /merchants" do
    it "returns a list of all merchants" do
      create_list(:merchant, 2)
      
    end
  end
end
