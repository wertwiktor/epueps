class SubjectsController < ApplicationController

  def index
  	@subjects = Subject.all
  end

  def show
  	@subject = Subject.find(params[:id])
  	@lessons = @subject.lessons.all
  end
end
