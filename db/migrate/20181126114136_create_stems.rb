class CreateStems < ActiveRecord::Migration[5.2]
  def change
    create_table :stems do |t|
      t.string :name
      t.string :link
      t.references :beat, foreign_key: true

      t.timestamps
    end
  end
end
