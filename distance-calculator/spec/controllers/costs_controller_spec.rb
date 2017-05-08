require 'rails_helper'

describe CostsController, type: :request do
  subject { get "/cost", params: params }
  let(:point_a){ FactoryGirl.create() }

  describe "show" do


    context "when find the course" do
      let(:params){ { cost: { origin: "BLA", destination: "BLU", weight: 50 } } }
      let(:origin) { FactoryGirl.create(:location, name: "BLA") }
      let(:destiny) { FactoryGirl.create(:location, name: "BLU") }
      let!(:course){ FactoryGirl.create(:course, origin_location: origin, destiny_location: destiny, distance: 10) }

      it "is ok" do
        subject
        expect(response.response_code).to eq(200)
      end
    end

    context "when not found course" do
      let(:params){ { cost: { origin: "HI", destination: "BYE", weight: 50 } } }
      it "return error" do
        subject
        expect(response.response_code).to eq(422)
      end
    end
  end
end