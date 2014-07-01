class Ticket < ActiveRecord::Base
  validates :title, :description, presence: true
  
  belongs_to :project
end
