require 'rails_helper'

describe LocationsController, type: :request do
  subject { post "/cost/distance", params: params }
  let(:point_a){ FactoryGirl.create() }

  describe "show" do
    context "when find the course" do
      let(:params){ { cost: { origin: "BLA", destination: "BLU", weight: 50 } } }

      it "is ok" do

      end
    end
  end
end