class LessonsController < ApplicationController
	
	def index
		@subject = Subject.find(params[:subject_id])
		@lessons = @subject.lessons.all
	end
end
