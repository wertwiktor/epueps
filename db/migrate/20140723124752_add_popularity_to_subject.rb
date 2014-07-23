class AddPopularityToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :popularity, :integer, default: 0
  end
end
