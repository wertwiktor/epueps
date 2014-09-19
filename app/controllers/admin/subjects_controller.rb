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

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      flash[:success] = "Dodano przedmiot"
      redirect_to admin_subjects_path
    else
      if @subject.errors.any?
        flash.now[:error] = %Q(
          Wystąpiły błędy w formularzu.
          )
      else 
        flash.now[:error]= "Nieznany błąd. Spróbuj ponownie później"
      end
      render 'new'
    end


  end


  private

  def subject_params
    params.require(:subject).permit(:name, 
                                    :intro_video_link,
                                    :description)
  end
end
