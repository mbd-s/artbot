class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :art, index: true, foreign_key: true
      t.string :text
      t.string :answer

      t.timestamps null: false
    end
  end
end
