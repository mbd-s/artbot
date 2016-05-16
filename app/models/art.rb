class Art < ActiveRecord::Base
  belongs_to :artist
  has_many :questions
end
