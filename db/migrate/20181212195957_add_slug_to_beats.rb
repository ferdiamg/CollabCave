class AddSlugToBeats < ActiveRecord::Migration[5.2]
  def change
    add_column :beats, :slug, :string
    add_index :beats, :slug, unique: true
  end
end
