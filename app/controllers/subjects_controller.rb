class SubjectsController < ApplicationController

  def index
    if subjects_scope == "popular"
      @subjects = Subject.popular
    else
      @subjects = Subject.recent
    end

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

    if @lessons.any?
      if params[:lesson_id]
        @current_lesson = Lesson.find(params[:lesson_id]) 
      elsif current_lesson
        @current_lesson = @subject.lessons.find(current_lesson)
      else
        @current_lesson = @lessons.first
      end

      set_current_lesson @current_lesson

    end

    # TODO: Popularity based on cookies
  	@subject.update_attribute(:popularity, @subject.popularity + 1)

  	respond_to do |format|
  		format.html
      format.js 
  	end
  end

  def info
    
  end

  private

    def subjects_scope
      params[:order] || cookies[:subject_scope] || "most_recent"
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
