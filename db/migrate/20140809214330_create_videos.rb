class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :video_link
      t.integer :resource_id

      t.timestamps
    end
  end
end
