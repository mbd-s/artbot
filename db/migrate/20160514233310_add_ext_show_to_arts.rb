class AddExtShowToArts < ActiveRecord::Migration
  def change
    add_column :arts, :ext_show, :string
  end
end
