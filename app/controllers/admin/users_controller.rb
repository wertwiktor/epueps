class Admin::UsersController < ApplicationController
  include Admin

  layout 'admin'
  
  before_action :authenticate_admin

  def index
    @users = SortAndFilterData.call(User, params)

    unless @users.any?
      redirect_to admin_users_path, notice: 'Nie znaleziono użytkownika' 
    end

    @search_params = params[:search]
  end


  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = 'Usunięto profil użytkownika'
      redirect_to :back
    else
      flash[:error] = 'Wystąpił błąd, spróbuj ponownie'
    end  
  end
    
end
