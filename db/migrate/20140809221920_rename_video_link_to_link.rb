class RenameVideoLinkToLink < ActiveRecord::Migration
  def change
    rename_column :videos, :video_link, :link
    add_column :videos, :name, :string  
  end
end
