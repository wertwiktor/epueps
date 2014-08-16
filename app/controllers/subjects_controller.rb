class SubjectsController < ApplicationController

  include CurrentVideo

  def index
    @scope = subjects_scope

    if @scope == "popular"
      @subjects = Subject.popular
    else
      @subjects = Subject.recent
    end

    cookies[:subject_scope] = @scope

    respond_to do |format|
      format.html
      format.js
      format.json
    end

  end

  def show
  	@subject = Subject.find(params[:id])
  	@lessons = @subject.lessons.all
    
    # TODO: Load from user profile

    @current_video = current_video(@subject)

    if @current_video
      @current_lesson = @current_video.lesson

      unless @current_video.lesson.subject == @subject
        raise 'WrongVideoId' 
      end 

      set_current_video(@subject, @current_video)
    # else
    #   raise 'VideoNotFound'
    end

    # TODO: Popularity based on cookies
  	@subject.update_attribute(:popularity, @subject.popularity + 1)

  	respond_to do |format|
  		format.html
      format.js 
  	end
  end

  def info
    @subject = Subject.find(params[:subject_id])
    @lessons = @subject.lessons.all
  end

  private

    def subjects_scope
      params[:order] || cookies[:subject_scope] || "recent"
    end

    def subject_scope=(scope)
      cookies[:subject_scope] = scope
    end

    def current_lesson
      cookies["s-#{@subject.id}_lesson_id"]
    end

    def set_current_lesson (lesson)
      cookies["s-#{@subject.id}_lesson_id"] = lesson.id
    end
end
