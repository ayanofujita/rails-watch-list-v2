class Genre < ApplicationRecord
  has_and_belongs_to_many :movies
  validates :name, presence: true
  validate :no_duplicate_movies

  private

  def no_duplicate_movies
    if movies.uniq.size != movies.size
      errors.add(:movies, "can't have duplicates")
    end
  end
end
