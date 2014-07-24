class Subject < ActiveRecord::Base
	has_many :lessons, dependent: :destroy

	# TODO: Model validation & spec

	scope :most_popular, -> { order('popularity DESC') } 


	def image_src
		if self.image_name
			"subjects/#{self.image_name}" 
		else
			"subjects/subject-#{self.id}.jpg"
		end
	end

	def increase_popularity
		self.popularity += 1
	end
end
