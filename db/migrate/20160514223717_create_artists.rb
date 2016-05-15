class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :birth
      t.string :death
      t.string :nationality

      t.timestamps null: false
    end
  end
end
