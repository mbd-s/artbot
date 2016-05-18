class Art < ActiveRecord::Base
  belongs_to :artist
  has_many :questions

  validates :image, presence: true
  validates :title, :year, :century, :medium, presence: true
  # callback to delete dependant questions first
  before_destroy :delete_questions

  def delete_questions
    self.questions.destroy_all
  end
end
