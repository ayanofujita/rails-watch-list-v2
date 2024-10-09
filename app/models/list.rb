class List < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_and_belongs_to_many :movies
  validates :name, presence: true
  validates :name, length: { maximum: 55 }
  validates :description, length: { maximum: 400 }
  validate :has_atleast_5

  def has_atleast_5
    errors.add(:movies, "must have at least 5 movies") if movies.size < 5
  end

  def first_5
    self.movies.first(5)
  end
end
