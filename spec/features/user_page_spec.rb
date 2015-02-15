require 'rails_helper'

describe "User page" do


  describe "when ratings exists" do
    let!(:style) { FactoryGirl.create :style, name:"Jallumainen" }
    let!(:brewery) { FactoryGirl.create :brewery, name:"anonymous" }
    let!(:user) { FactoryGirl.create :user }
    let!(:beer) {FactoryGirl.create :beer}
    let!(:rating) { FactoryGirl.create :rating, user:user, beer:beer}

    before :each do
       sign_in(username:"Pekka", password:"Foobar1")
    end

    it "users favorite style is shown on users page" do
      visit user_path(user)
      
      expect(page).to have_content "Favorite style: Jallumainen"
    end

    it "users favorite brewery is shown on users page" do
      visit user_path(user)
      
      expect(page).to have_content "Favorite brewery: anonymous"
    end

    it "users favorite beer is shown on users page" do
      visit user_path(user)

      expect(page).to have_content "Favorite beer: Testiolut IVA"
    end

    it "user can delete own rating" do
      visit user_path(user)

      click_link('delete')
      
      expect(page).to have_content "User has not given any ratings!"
    end

  end

end 