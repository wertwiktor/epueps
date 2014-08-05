class AddIntroLinkToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :intro_video_link, :string
  end
end
