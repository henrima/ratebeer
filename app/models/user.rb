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
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end
  
  #def favorite_style 
  #  return nil if ratings.empty?
  #  return highest_rated_style
  #end


  #def favorite_brewery
  #	return nil if ratings.empty?
  #	
  #end



  #def highest_rated_style
  #	t = Hash[:style => "avg", :count => 0]
  #	User.all.each{ |u| u.beers.each{ |b| t[b.style] =  b.average_rating} }	
  #	averages = {}
  #	user.beers.all.each do |b| 
  #  end	
  #  byebug
  #end

end
