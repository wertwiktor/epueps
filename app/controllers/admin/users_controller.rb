class Admin::UsersController < ApplicationController

  include Admin

  helper_method :sort_column
  helper_method :sort_direction
  
  layout 'admin'
  
  before_action :authenticate_admin

  def index
    @users = all_or_searched_users

    unless @users.any?
      redirect_to admin_users_path, notice: "Nie znaleziono użytkownika" 
    end

    @search_params = params[:search]
  end


  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "Usunięto profil użytkownika"
      redirect_to :back
    else
      flash[:error] = "Wystąpił błąd, spróbuj ponownie"
    end  
  end

  private

  def all_or_searched_users
    unless params[:search].nil?
      User.where('email ~* :pattern', pattern: params[:search]) 
    else
      get_sorted_users
    end
  end

  def sort_column
    params[:sort] if User.column_names.include?(params[:sort])
  end

  def sort_direction
    params[:direction] if %{asc desc}.include?(params[:direction])
  end

  def get_sorted_users
    unless sort_column.nil?
      return User.order(sort_column + " " + sort_direction)
    else
      return User.all
    end
  end
end
