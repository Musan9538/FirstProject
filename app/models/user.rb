class User < ApplicationRecord
  has_secure_password
  has_many :harvests, dependent: :destroy
  
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, on: :create
end
 