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

end
