class Beer < ActiveRecord::Base

	belongs_to :brewery
	has_many :ratings, dependent: :destroy
	has_many :raters, -> { uniq }, through: :ratings, source: :user

 	validates :name, presence: true

	def avarage_rating
		ratings = Rating.all.where beer_id:self.id
		ratings.average(:score)
	end

	def to_s
		"#{self.name} #{self.brewery.name}"
	end

	def average
		return 0 if ratings.empty?
    	ratings.map { |r| r.score }.sum / ratings.count.to_f
  	end


end
