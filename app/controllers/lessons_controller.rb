class LessonsController < ApplicationController
	
	def show
		@lesson = Lesson.find(params[:id])
		@subject = @lesson.subject
	end
end
