class SubjectsController < ApplicationController

  def index
  	@subjects = Subject.all
  end

  def show
  	@subject = Subject.find(params[:id])
  	@lessons = @subject.lessons.all

  	@subject.update_attribute(:popularity, @subject.popularity + 1)

  	respond_to do |format|
  		format.html
  	end
  end
end
