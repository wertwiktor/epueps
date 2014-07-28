class Subject < ActiveRecord::Base
	has_many :lessons, dependent: :destroy

	scope :popular, -> { order('popularity DESC') }
	scope :recent,	 -> { order('created_at DESC') }

	validates :name, 	presence: { message: "Nazwa nie może być pusta" }
	validates :description, presence: {message: "Opis nie może być pusty"}


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
