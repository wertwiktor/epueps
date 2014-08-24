class Admin::UsersController < ApplicationController
  before_filter :authenticate_admin

  include Admin
  
  layout 'admin'

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
      User.all 
    end
  end
end
