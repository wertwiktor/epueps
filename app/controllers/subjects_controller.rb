class SubjectsController < ApplicationController

  def index
  	@subjects_most_recent = Subject.most_recent
    @subjects_most_popular = Subject.most_popular

    if subjects_scope == "most_recent"
      @subjects = @subjects_most_recent
    else
      @subjects = @subjects_most_popular
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
      cookies[:subject_scope] || "most_recent"
    end

    def subject_scope=(scope)
      cookies[:subject_scope] = scope
    end
end
