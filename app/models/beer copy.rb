class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings

	def avarage_rating
		ratings = Rating.all.where beer_id:self.id
		sum = 0.0

		ratings.each do |r|
			sum += r.score
		end

		avg = sum / ratings.count

		avg
	end
end
