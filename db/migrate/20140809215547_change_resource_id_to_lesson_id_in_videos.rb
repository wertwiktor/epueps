class ChangeResourceIdToLessonIdInVideos < ActiveRecord::Migration
  def change
    rename_column :videos, :resource_id, :lesson_id  
  end
end
