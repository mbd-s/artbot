class Artist < ActiveRecord::Base
  has_many :artworks, class_name: :Art
end
