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
      redirect_to admin_subject_path(@subject)
    else
      if @lesson.errors.any?
        flash.now[:error] = "Wystąpiły błędy w formularzu. Liczba błędów: #{@lesson.errors.count}" 
      else
        flash.now[:error] = "Nieznany błąd. Spróbuj ponownie później"
      end
      render 'new'
    end
  end

  def show
    @lesson = Lesson.find(params[:id])
    @subject = @lesson.subject
    @videos = @lesson.videos
  end

  def destroy
    @lesson = Lesson.find(params[:id])

    if @lesson.destroy
      flash[:success] = "Usunięto lekcję"
      redirect_to admin_subject_path(@lesson.subject)
    else
      flash[:error] = "Wystąpił błąd. Spróbuj ponownie później"
    end


  end

  private

  def lesson_params
    params.require(:lesson).permit(:name, :video_link, :description)
  end

end
