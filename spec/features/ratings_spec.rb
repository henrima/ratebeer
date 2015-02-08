require 'rails_helper'

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")

  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "ratings and their count is shown on ratings page" do
  	FactoryGirl.create :rating, beer:beer1, user:user
  	FactoryGirl.create :rating2, beer:beer1, user:user
  	FactoryGirl.create :rating3, beer:beer2, user:user

  	visit ratings_path
  	expect(Rating.count).to eq(3)
  	expect(page).to have_content("Number of ratings: 3")
  end

  it "show ratings on user page" do   
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"}.to change{Rating.count}.from(0).to(1)

  	visit "/users/#{user.id}"
    expect(page).to have_content "Ratings average: 15.0"  
    expect(page).to have_content "iso 3 15"
    expect(page).to have_content "Number of ratings: 1"
  end


end