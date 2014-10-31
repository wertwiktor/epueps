class Admin::SubjectsController < ApplicationController
  include Admin

  layout 'admin'

  before_action :authenticate_admin
  before_action :set_subject, only: [:show, :destroy, :edit, :update]

  # Add sortable table after moving sorting code to seperate class

  def index
    @subjects = SortAndFilterData.call(Subject, params)
  end

  def destroy
    if @subject.destroy
      flash[:success] = 'Usunięto przedmiot'
      redirect_to :back
    else 
      flash[:error] = 'Wystąpił błąd, spróbuj ponownie'
    end
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      flash[:success] = 'Dodano przedmiot'
      redirect_to admin_subjects_path and return
    elsif @subject.errors.any?
      flash.now[:error] = 'Wystąpił błąd' 
      render 'new'
    end

  end

  def update
    if @subject.update_attributes(subject_params)
      flash[:success] = 'Zaktualizowano przedmiot'
      redirect_to admin_subjects_path
    else
      flash.now[:error] = 'Wystąpił błąd'
      render 'edit'
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:name,
                                    :intro_video_link,
                                    :description)
  end

  def set_subject
    @subject = Subject.find(params[:id])

    if @subject.nil?
      flash[:error] = 'Nie znaleziono takiego przedmiotu'
      redirect_to admin_subjects_path
    end
  end
end
