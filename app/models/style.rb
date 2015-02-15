class Style < ActiveRecord::Base
  validates :name, length: { minimum: 1 }

  def to_s
    "#{name}"
  end
end
