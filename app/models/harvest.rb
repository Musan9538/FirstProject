class Harvest < ApplicationRecord
  belongs_to :user
  
  validates :date, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
 