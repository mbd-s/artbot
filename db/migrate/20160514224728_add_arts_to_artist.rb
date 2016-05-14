class AddArtsToArtist < ActiveRecord::Migration
  def change
    add_reference :artists, :arts, index: true, foreign_key: true
  end
end
