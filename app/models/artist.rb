class Artist < ActiveRecord::Base
  has_many :arts

  validates :name, :birth, :death, :nationality, presence: true
  
  # callback to delete dependent questions first
  before_destroy :delete_arts

  def delete_arts
    self.arts.destroy_all
  end
end
