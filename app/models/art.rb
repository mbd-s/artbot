class Art < ActiveRecord::Base
  belongs_to :artist
  accepts_nested_attributes_for :artist
  has_many :questions
end
