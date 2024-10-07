class List < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_and_belongs_to_many :movies
  validates :name, presence: true
  validates :name, length: { maximum: 20 }
  validates :description, length: { maximum: 250 }
end
