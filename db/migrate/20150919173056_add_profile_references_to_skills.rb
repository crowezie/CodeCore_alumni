class AddProfileReferencesToSkills < ActiveRecord::Migration
  def change
    add_reference :skills, :profile, index: true, foreign_key: true
  end
end
