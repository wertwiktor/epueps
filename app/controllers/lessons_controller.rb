class LessonsController < ApplicationController
	
	def show
		@lesson = Lesson.find(params[:id])
		@subject = @lesson.subject
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
				flash[:error] = "Wystąpiły błędy w formularzu. Liczba błędów: #{@lesson.errors.count}" 
			else
				flash[:error] = "Nieznany błąd. Spróbuj ponownie później"
			end
			render 'new'
		end
	end

	private

	def lesson_params
		params.require(:lesson).permit(:name, :video_link, :description)
	end

end
