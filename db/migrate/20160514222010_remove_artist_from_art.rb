class RemoveArtistFromArt < ActiveRecord::Migration
  def change
    remove_column :arts, :artist, :string
  end
end
