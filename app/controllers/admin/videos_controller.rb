class Admin::VideosController < ApplicationController

  include Admin

  layout 'admin'

  before_action :authenticate_admin

  def new
    @video = Video.new
    @lesson = Lesson.find(params[:lesson_id])
    @subject = @lesson.subject
  end

  def create
    @lesson = Lesson.find(params[:lesson_id])
    @subject = @lesson.subject
    @video = @lesson.videos.build(video_params)

    if @video.save
      flash[:success] = "Dodano film"
      redirect_to admin_subject_lesson_path(@subject, @lesson) and return
    elsif @video.errors.any?
      flash.now[:error] = "Wystąpiły błędy w formularzu"
    else
      flash.now[:error] = "Wystąpił nieznany błąd"
    end

    render 'new'
  end


  def video_params
    params.require(:video).permit(:name, :link)
  end
end
