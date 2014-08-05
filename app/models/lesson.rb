class Lesson < ActiveRecord::Base
	belongs_to :subject

	before_save :validate_link

	include YoutubeUtilities

	
	validates :subject_id, 	presence: true
	validates :name,				presence:  
													{ message: "Nazwa nie może być pusta" }
	validates :description, presence: 
													{ message: "Opis nie może być pusty" }
	validates :video_link, 	presence:
													{ message: "Link do filmu nie może być pusty" },
													format: 
													{ with: VIDEO_LINK_REGEX,
														message: "Niepoprawny format"
													}

	protected

	def validate_link
		self.video_link = validate_youtube_link(self.video_link)
	end
end
