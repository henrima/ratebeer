require 'rails_helper'


describe "Beer" do
  before :each do
    FactoryGirl.create :beer
  end

  it "can be created with valid name through web page" do
  	visit new_beer_path
    fill_in('beer[name]', with:'Testiolut IVA')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(1).to(2)
  end

  it "returns to new_beer with correct error if no valid values" do
  	visit new_beer_path
    fill_in('beer[name]', with:'')
    click_button "Create Beer"

    expect(current_path).to eq(beers_path)
    expect(page).to have_content "Name can't be blank"
    expect(Beer.count).to eq(1)
  end

 end