class AddImageNameToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :image_name, :string
  end
end
