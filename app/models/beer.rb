class Beer < ActiveRecord::Base
	include RatingAverage	

	belongs_to :style
	belongs_to :brewery

	has_many :ratings, dependent: :destroy
	has_many :raters, -> { uniq }, through: :ratings, source: :user

 	validates :name, presence: true
    validates :name, length: { minimum: 1 }
 	validates :style, presence: true
 	

	def to_s
		"#{self.name} #{self.brewery.name}"
	end

 	def self.top(n)
   		sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) }
   		# palauta listalta parhaat n kappaletta
   		# miten? ks. http://www.ruby-doc.org/core-2.1.0/Array.html
 	end

end
