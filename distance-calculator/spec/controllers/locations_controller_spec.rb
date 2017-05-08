require 'rails_helper'

describe LocationsController, type: :request do
  subject { post "/locations/distance", params: params }

  describe "distance" do

    context "when attributes are ok" do

      let(:params){ { course: { origin_name: "BLA", destiny_name: "BLU", distance: 100 } } }

      it "return ok" do
        subject
        expect(response.response_code).to eq(200)
      end

    end

    context "when has invalid attributes" do

      let(:params){ { course: { distance: 100 } } }

      it "return unprocessable_entity" do
        subject
        expect(response.response_code).to eq(422)
      end
    end

    context "when course already exists" do
      let(:origin) { FactoryGirl.create(:location, name: "BLA") }
      let(:destiny) { FactoryGirl.create(:location, name: "BLU") }
      let!(:course){ FactoryGirl.create(:course, origin_location: origin, destiny_location: destiny, distance: 10) }
      let(:params){ { course: { origin_name: "BLA", destiny_name: "BLU", distance: 100 } } }

      it "return unprocessable_entity" do
        subject
        expect(response.response_code).to eq(422)
      end
    end
  end
end