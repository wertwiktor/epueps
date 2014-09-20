class Admin::SubjectsController < ApplicationController

  include Admin

  layout 'admin'

  before_action :authenticate_admin
  before_action :set_subject_from_id, only: [:destroy, :edit, :update]

  def index
    @subjects = Subject.all
  end

  def destroy
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
    elsif @subject.errors.any?
      flash.now[:error] = %Q(
        Wystąpiły błędy w formularzu.
        )
      render 'new'
    else 
      flash.now[:error]= "Nieznany błąd. Spróbuj ponownie później"
      render 'new'
    end
  end


  def update
    if @subject.update_attributes(subject_params)
      flash[:success] = "Zaktualizowano przedmiot"
      redirect_to admin_subjects_path
    elsif @subject.errors.any?
      flash.now[:error] = "Wystąpiły błędy w formularzu"
      render 'edit'
    else
      flash.now[:error] = "Wystąpił nieznany błąd. Spróbuj ponownie później"
      render 'edit'
    end
  end


  private

  def subject_params
    params.require(:subject).permit(:name, 
                                    :intro_video_link,
                                    :description)
  end

  def set_subject_from_id
    @subject = Subject.find(params[:id])

    if @subject.nil?
      flash[:error] = "Nie znaleziono takiego przedmiotu"
      redirect_to admin_subjects_path
    end
  end
end
