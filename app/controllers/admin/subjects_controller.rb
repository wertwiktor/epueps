class Admin::SubjectsController < ApplicationController

  include Admin

  layout 'admin'

  before_action :authenticate_admin

  def index
    @subjects = Subject.all
  end

  def destroy
    @subject = Subject.find(params[:id])

    if @subject.destroy
      flash[:success] = "Usunięto przedmiot"
      redirect_to :back
    else 
      flash[:error] = "Wystąpił błąd, spróbuj ponownie"
    end

  end
end
