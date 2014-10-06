class AddVideosCountToLessons < ActiveRecord::Migration

  def up
    add_column  :lessons, 
                :videos_count, 
                :integer, 
                default: 0, 
                null: false

    Lesson.find_each do |result|
      Lesson.reset_counters(result.id, :videos)
    end
  end


  def down
    remove_column :lessons, :videos_count
  end

end

