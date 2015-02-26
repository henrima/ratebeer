class Brewery < ActiveRecord::Base
  include RatingAverage

	has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :year, numericality: {only_integer: true, 
                                  greater_than_or_equal_to: 1042}

  validates :name, presence: true                                

  validate :year, :validate_current_year
                                
  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

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

  def validate_current_year
    if year > Date.today.year
      errors.add(:year, "brewery cannot be from da future")
    end
  end

  def self.top(n)
    unless Brewery.all.empty?
      sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }
      sorted_by_rating_in_desc_order.first(n)
    else
      return []
    end  
  end

end
