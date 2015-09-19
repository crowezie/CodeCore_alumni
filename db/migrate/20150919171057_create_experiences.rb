class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :position
      t.string :company
      t.text :description
      t.string :weblink
      t.string :logo

      t.timestamps null: false
    end
  end
end
