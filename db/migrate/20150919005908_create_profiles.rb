class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :description
      t.boolean :availability
      t.text :pitch
      t.string :image
      t.string :phone
      t.string :email
      t.string :location
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
