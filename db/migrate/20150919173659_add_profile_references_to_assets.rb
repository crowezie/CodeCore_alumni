class AddProfileReferencesToAssets < ActiveRecord::Migration
  def change
    add_reference :assets, :profile, index: true, foreign_key: true
  end
end
