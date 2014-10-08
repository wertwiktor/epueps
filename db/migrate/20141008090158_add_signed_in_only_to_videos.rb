class AddSignedInOnlyToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :signed_in_only, :boolean, default: false
  end
end
