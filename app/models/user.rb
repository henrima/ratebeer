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


  def favorite_style
    return nil if ratings.empty?
    
    style_scores = {}

    ratings.each do |r|
      if style_scores[r.beer.style].nil?
        style_scores[r.beer.style] = average_for_style(r.beer.style)
      end
    end

    style_scores.sort_by {|style, score| score}.last.first
  end

  def average_for_style(style)
    style_ratings = ratings.find_all{ |r| r.beer.style == style}
    style_ratings.map{ |r| r.score }.sum / style_ratings.count.to_f
  end

  def favorite_brewery
    return nil if ratings.empty?
    
    brewery_scores = {}

    ratings.each do |r|
      if brewery_scores[r.beer.brewery].nil?
        brewery_scores[r.beer.brewery] = average_for_brewery(r.beer.brewery)
      end
    end

    brewery_scores.sort_by {|brewery, score| score}.last.first
  end

  def average_for_brewery(brewery)
    brewery_ratings = ratings.find_all{ |r| r.beer.brewery == brewery}
    brewery_ratings.map{ |r| r.score}.sum / brewery_ratings.count.to_f
  end


end
