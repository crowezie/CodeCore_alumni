class AddProfileReferencesToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :profile, index: true, foreign_key: true
  end
end
