class AddNameAndDescriptionToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :name, :string
    add_column :subjects, :description, :text
  end
end
