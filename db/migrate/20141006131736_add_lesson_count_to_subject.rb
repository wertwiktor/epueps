class AddLessonCountToSubject < ActiveRecord::Migration

  def up
    add_column  :subjects, 
                :lessons_count, 
                :integer, 
                default: 0, 
                null: false

    Subject.find_each do |result|
      Subject.reset_counters(result.id, :lessons)
    end
  end


  def down
    remove_column :subjects, :lessons_count
  end

end
