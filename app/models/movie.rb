class Movie < ApplicationRecord
  has_and_belongs_to_many :lists
  validates :title, :overview, :poster_url, rating, presence: true
  validates :title, uniqueness: true
end
