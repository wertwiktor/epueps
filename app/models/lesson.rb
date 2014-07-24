class Lesson < ActiveRecord::Base
	belongs_to :subject

	# TODO: Model validation & spec
	validates :subject_id, presence: true



	# TODO: Add video_id function which can deal with links 
	# 			from videos from playlists

	def embed_link
		self.video_link.gsub("watch?v=", "embed/") + video_params
	end

	def video_params
		"?rel=0&fs=1&autohide=0&showinfo=0"
	end

	def video_thumbnail
		"http://img.youtube.com/vi/#{self.video_id}/1.jpg"
	end

	def video_id
		self.video_link.gsub(/^.*v=/, "")
	end
end
