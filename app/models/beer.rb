class Beer < ActiveRecord::Base

	belongs_to :brewery
	has_many :ratings, dependent: :destroy

	def avarage_rating
		ratings = Rating.all.where beer_id:self.id
		ratings.average(:score)
	end

	def to_s
		"#{self.name} #{self.brewery.name}"
	end

end
