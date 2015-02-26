require 'rails_helper'

describe Beer do
	let!(:style) { FactoryGirl.create :style, name:"Jallumainen" }

	it "validates and stores to database with name and style set" do

		beer = Beer.create name:"Iso 3", style:style

		expect(beer).to be_valid
		expect(Beer.count).to eq(1)
    end

	it "does not validate without a name" do
		beer = Beer.create style:style

		expect(beer).not_to be_valid
		expect(Beer.count).to eq(0)
    end

	it "does not validate without a style" do
		beer = Beer.create name:"Iso 3"

		expect(beer).not_to be_valid
		expect(Beer.count).to eq(0)
    end

end