class Art < ActiveRecord::Base
  belongs_to :artist
  has_many :questions

  validates :image, format: {with: /\.(png|jpg)\Z/i}, presence: true
  validates :title, :artist, :year, :century, :medium, presence: true
end
