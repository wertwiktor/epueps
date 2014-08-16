class LessonsController < ApplicationController
	
	include CurrentVideo

	# TODO: This is not needed so let's delete it
	def show
		@lesson = Lesson.find(params[:id])
		# TODO: Add memoization
		@subject = @lesson.subject
		@current_lesson_video = 
			current_video(@subject) if @lesson.videos.any?
	end

	def new
		@lesson = Lesson.new
		@subject = Subject.find(params[:subject_id])
	end

	def create
		@subject = Subject.find(params[:subject_id])
		@lesson = @subject.lessons.build(lesson_params)

		if @lesson.save
			flash[:success] = "Dodano lekcję"
			redirect_to @subject
		else
			if @lesson.errors.any?
				flash.now[:error] = "Wystąpiły błędy w formularzu. Liczba błędów: #{@lesson.errors.count}" 
			else
				flash.now[:error] = "Nieznany błąd. Spróbuj ponownie później"
			end
			render 'new'
		end
	end

	private

	def lesson_params
		params.require(:lesson).permit(:name, :video_link, :description)
	end

end
