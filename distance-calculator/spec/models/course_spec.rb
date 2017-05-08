require 'rails_helper'

RSpec.describe Course, type: :model do
  subject { FactoryGirl.build(:course) }

  it { should validate_numericality_of(:distance) }

  it "has a valid factory" do
    expect(subject).to be_valid
  end

  context "when route exists" do
    let(:origin){ FactoryGirl.create(:location, name: "A") }
    let(:destiny){ FactoryGirl.create(:location, name: "B") }
    let!(:course){ FactoryGirl.create(:course, origin_location: origin, destiny_location: destiny, distance: 10) }

    it "is invalid" do
      subject.origin_location = origin
      subject.destiny_location = destiny

      expect(subject).to_not be_valid
    end
  end
end
