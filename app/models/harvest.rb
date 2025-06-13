class Harvest < ApplicationRecord
  belongs_to :user
  
  validates :date, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  def self.accessible_by(user)
    user.is_admin? ? all : user.harvests
  end
end
 