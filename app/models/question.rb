class Question < ActiveRecord::Base
  belongs_to :art

  validates :text, :answer, presence: true

end
