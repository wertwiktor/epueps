class Subject < ActiveRecord::Base
	has_many :lessons, dependent: :destroy


	def image_src
		if self.image_name
			"subjects/#{self.image_name}" 
		else
			"subjects/subject-#{self.id}.jpg"
		end
	end
end
