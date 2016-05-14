class RemoveArtIdFromArtist < ActiveRecord::Migration
  def change
    remove_reference :artists, :art, index: true, foreign_key: true
  end
end
