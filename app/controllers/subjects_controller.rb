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


    # TODO: Load from user profile/
    # TODO: lesson_id cookie attr getter & setter

    if params[:lesson_id]
      @current_lesson = Lesson.find(params[:lesson_id]) 
    elsif cookies["s-#{@subject.id}_lesson_id"]
      @current_lesson = @subject.lessons.find(cookies["s-#{@subject.id}_lesson_id"])
    else
      @current_lesson = @lessons.first
    end

    cookies["s-#{@subject.id}_lesson_id"] = @current_lesson.id


    # TODO: Popularity based on cookies
  	@subject.update_attribute(:popularity, @subject.popularity + 1)

  	respond_to do |format|
  		format.html
      format.js 
  	end
  end


  def index_most_popular
    @subjects = Subject.most_popular
    subject_scope = "most_popular"

    respond_to do |format|
      format.html { render 'index' }
      format.js  { render 'index.js.erb' }
    end
  end

  def index_most_recent
    @subjects = Subject.most_recent
    subject_scope = "most_recent"

    respond_to do |format|
      format.html { render 'index' }
      format.js { render 'index.js.erb'}
    end
  end


  private

    def subjects_scope

      params[:order] || cookies[:subject_scope] || "most_recent"
    end

    def subject_scope=(scope)
      cookies[:subject_scope] = scope
    end
end
