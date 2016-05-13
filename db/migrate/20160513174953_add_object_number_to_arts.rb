class AddObjectNumberToArts < ActiveRecord::Migration
  def change
    add_column :arts, :object_number, :string
  end
end
