class Artist < ActiveRecord::Base
  has_many :arts

  # callback to delete dependant questions first
  before_destroy :delete_arts

  def delete_arts
    self.arts.destroy_all
  end
end
