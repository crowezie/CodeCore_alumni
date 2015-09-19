class AddProfileReferencesToInquiries < ActiveRecord::Migration
  def change
    add_reference :inquiries, :profile, index: true, foreign_key: true
  end
end
