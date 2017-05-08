require 'rails_helper'

RSpec.describe CostService, type: :service do
  context "invalid" do
    context "when not find location" do
      subject { CostService.new("A", "B", 5) }

      it "is invalid" do
        expect(subject).to_not be_valid
      end
    end
  end

  context "valid" do
    let(:location_a) { FactoryGirl.create(:location, name: "A") }
    let(:location_b) { FactoryGirl.create(:location, name: "B") }
    let(:location_c) { FactoryGirl.create(:location, name: "C") }

    let!(:course_1){ FactoryGirl.create(:course, origin_location: location_a, destiny_location: location_b, distance: 10) }
    let!(:course_2){ FactoryGirl.create(:course, origin_location: location_b, destiny_location: location_c, distance: 15) }
    let!(:course_3){ FactoryGirl.create(:course, origin_location: location_a, destiny_location: location_c, distance: 30) }

    context "when find shortest path" do
      subject { CostService.new("A", "C", 5) }
      it "return path and cost" do
        expect(subject.cost_and_path).to eq({ path: ["A", "B", "C"], cost: 18.75 })
      end
    end

    context "when destiny is equal than origin" do
      subject { CostService.new("A", "A", 5) }
      it "return 0" do
        expect(subject.cost_and_path).to eq({ path: ["A"], cost: 0 })
      end
    end
  end
end
