class Admin::LessonsController < ApplicationController

  before_filter :authenticate_admin
  
  include CurrentVideo
  include Admin

  layout 'admin'

  def new
    @lesson = Lesson.new
    @subject = Subject.find(params[:subject_id])
  end

  def create
    @subject = Subject.find(params[:subject_id])
    @lesson = @subject.lessons.build(lesson_params)

    if @lesson.save
      flash[:success] = "Dodano lekcję"
      # TODO: Change redirect path
      redirect_to admin_path
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
