class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :linkedin
      t.string :github
      t.string :twitter
      t.string :resume

      t.timestamps null: false
    end
  end
end
