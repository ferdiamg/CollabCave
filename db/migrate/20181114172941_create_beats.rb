class CreateBeats < ActiveRecord::Migration[5.2]
  def change
    create_table :beats do |t|
      t.string :name
      t.integer :bpm
      t.string :key
      t.string :link
      t.references :user
      
      t.timestamps
    end
  end
end
