require_relative "../config"

class AddImageToRevisions < ActiveRecord::Migration
  def up
    add_column :revisions, :primary_image_url, :string
  end # up


  def down
    remove_column :revisions, :primary_image_url
  end # down

end # AddImageToRevisions

AddImageToRevisions.migrate(ARGV[0]) if ARGV[0]