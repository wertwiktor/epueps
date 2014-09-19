class Admin::SubjectsController < ApplicationController

  include Admin

  layout 'admin'

  before_action :authenticate_admin
  
  def index
    @subjects = Subject.all
  end
end
