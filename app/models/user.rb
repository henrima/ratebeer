class User < ActiveRecord::Base
	include RatingAverage

	has_secure_password

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings

	has_many :memberships, dependent: :destroy
	has_many :beer_clubs, through: :memberships


	validates :username, uniqueness: true,
						length: { minimum: 3, maximum: 15 }

	validates :password, :format => {:with => /[A-Z]/,
                          message: "must have atleast one capitalized character"}
	validates :password, :format => {:with => /[0-9]/,
                          message: "must have atleast one number"}
    validates :password, length: { minimum: 4 }



    def favorite_beer
    	if ratings.nil? 
    		return nil
    	end
    end
    	
end
