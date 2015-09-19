class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :school_name
      t.integer :year_from
      t.integer :year_to
      t.string :degree
      t.string :logo
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
