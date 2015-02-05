require 'rails_helper'

describe Beer do

	it "validates and stores to database with name and style set" do
		beer = Beer.create name:"Iso 3", style:"Lager"

		expect(beer).to be_valid
		expect(Beer.count).to eq(1)
    end

	it "does not validate without a name" do
		beer = Beer.create style:"Lager"

		expect(beer).not_to be_valid
		expect(Beer.count).to eq(0)
    end

	it "does not validate without a style" do
		beer = Beer.create name:"Iso 3"

		expect(beer).not_to be_valid
		expect(Beer.count).to eq(0)
    end

end