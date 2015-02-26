class ChangeStylesFromOldToNew < ActiveRecord::Migration
  def change
	add_column :beers, :style_id, :integer

	Beer.all.each do |b|
		if Style.where(name: b.old_style).empty?
			s = Style.new name:b.old_style
			s.save
		end

	  	b.style_id = Style.where(name: b.old_style).first.id
	  	b.save!
	end
  end
end
