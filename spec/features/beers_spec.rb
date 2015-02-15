require 'rails_helper'


describe "Beer" do
  let!(:style) { FactoryGirl.create :style, name:"Jallumainen" }
  let!(:brewery) { FactoryGirl.create :brewery, name:"anonymous" }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "can be created with valid name through web page when logged in" do
  	visit new_beer_path
    fill_in('beer[name]', with:'Testiolut IVA')
    select('Jallumainen', from:'beer[style_id]')
    select('anonymous', from:'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "returns to new_beer with correct error if no valid values when logged in" do
  	visit new_beer_path
    fill_in('beer[name]', with:'')
    click_button "Create Beer"

    expect(current_path).to eq(beers_path)
    expect(page).to have_content "Name can't be blank"
    expect(Beer.count).to eq(0)
  end

 end