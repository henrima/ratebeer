class Brewery < ActiveRecord::Base
  include RatingAverage

	has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :year, numericality: {only_integer: true, 
                                  greater_than_or_equal_to: 1042,
                                  less_than_or_equal_to: Date.today.year}

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = Date.today.year
    puts "changed year to #{year}"
  end

  def to_s
    self.name
  end
  
end
