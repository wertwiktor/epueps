class Admin::AdminPagesController < ApplicationController

  include Admin

  layout 'admin'

  before_action :authenticate_admin

  def home
    @subject_count = Subject.all.count
    @lesson_count = Lesson.all.count
    @video_count = Video.all.count
    @user_count = User.all.count
  end
end
