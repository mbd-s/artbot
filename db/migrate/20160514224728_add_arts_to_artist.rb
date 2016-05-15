class AddArtsToArtist < ActiveRecord::Migration
  def change
    add_reference :artists, :art, index: true, foreign_key: true
  end
end
