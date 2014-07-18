class AddNameAndVideoLinkToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :name, :string
    add_column :lessons, :video_link, :string
  end
end
