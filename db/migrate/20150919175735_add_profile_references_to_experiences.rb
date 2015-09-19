class AddProfileReferencesToExperiences < ActiveRecord::Migration
  def change
    add_reference :experiences, :profile, index: true, foreign_key: true
  end
end
