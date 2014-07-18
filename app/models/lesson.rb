class Lesson < ActiveRecord::Base
	belongs_to :subject

	validates :subject_id, presence: true


	def embed_link
		self.video_link.gsub("watch?v=", "embed/") + video_params
	end

	def video_params
		"?rel=0&fs=1&autohide=0&showinfo=1"
	end
end
