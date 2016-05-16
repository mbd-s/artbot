class RemoveExtShowFromArts < ActiveRecord::Migration
  def change
    remove_column :arts, :ext_show
  end
end
