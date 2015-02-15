require 'rails_helper'

describe "User page" do


  describe "when ratings exists" do
    let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
    let!(:beer) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
    let!(:user) { FactoryGirl.create :user }
    let!(:rating) { FactoryGirl.create :rating, user:user, beer:beer}

    it "users favorite style is shown on users page" do
      visit user_path(user)
      
      expect(page).to have_content "Favorite style: Lager"
    end

    it "users favorite brewery is shown on users page" do
      visit user_path(user)
      
      expect(page).to have_content "Favorite brewery: Koff"
    end

    it "users favorite beer is shown on users page" do
      visit user_path(user)

      expect(page).to have_content "Favorite beer: Karhu"
    end

    it "user can delete own rating" do
      sign_in(username:"Pekka", password:"Foobar1")
      visit user_path(user)

      click_link('delete')
      
      expect(page).to have_content "User has not given any ratings!"
    end

  end

end 