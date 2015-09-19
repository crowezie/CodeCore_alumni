class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :logo
      t.string :weblink
      t.string :sourcecode

      t.timestamps null: false
    end
  end
end
