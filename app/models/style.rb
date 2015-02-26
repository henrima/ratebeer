class Style < ActiveRecord::Base
	include RatingAverage	

  validates :name, length: { minimum: 1 }

  has_many :beers
  has_many :ratings, through: :beers

  def to_s
    "#{name}"
  end

  def self.top(n)
  	unless Style.all.empty?
    	sorted_by_rating_in_desc_order = Style.all.sort_by{ |s| -(s.average_rating||0) }
    	sorted_by_rating_in_desc_order.first(n)
    else
    	return []
    end
  end

end
