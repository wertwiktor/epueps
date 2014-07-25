class SubjectsController < ApplicationController

  def index
  	@subjects_most_recent = Subject.most_recent
    @subjects_most_popular = Subject.most_popular

    # TODO: Load this setting from cookies
    if subjects_scope == "most_recent"
      @subjects = @subjects_most_recent
    else
      @subjects = @subjects_most_popular
    end


  end

  def show
  	@subject = Subject.find(params[:id])
  	@lessons = @subject.lessons.all

  	@subject.update_attribute(:popularity, @subject.popularity + 1)

  	respond_to do |format|
  		format.html
  	end
  end


  private

    def subjects_scope
      cookies[:subject_scope] || "most_recent"
    end
end
