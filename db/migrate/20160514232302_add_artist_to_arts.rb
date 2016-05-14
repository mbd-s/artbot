class AddArtistToArts < ActiveRecord::Migration
  def change
    add_reference :arts, :artist, index: true, foreign_key: true
  end
end
