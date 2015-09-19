class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :projects, :logo, :logo_project
    rename_column :educations, :logo, :logo_education
    rename_column :experiences, :logo, :logo_experience
  end
end
