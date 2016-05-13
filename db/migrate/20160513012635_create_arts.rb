class CreateArts < ActiveRecord::Migration
  def change
    create_table :arts do |t|
      t.string :title
      t.string :artist
      t.string :image
      t.string :year
      t.string :century
      t.string :medium

      t.timestamps null: false
    end
  end
end
