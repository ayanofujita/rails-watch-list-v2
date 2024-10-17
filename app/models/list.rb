class List < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_and_belongs_to_many :movies
  validates :name, presence: true
  validates :name, length: { maximum: 55 }
  validates :description, length: { maximum: 400 }
  validate :has_atleast_5
  validate :no_duplicate_movies

  def first_5
    self.movies.first(5)
  end

  private

  def has_atleast_5
    errors.add(:movies, "must have at least 5 movies") if movies.size < 5
  end

  def no_duplicate_movies
    if movies.uniq.size != movies.size
      errors.add(:movies, "can't have duplicates")
    end
  end

  include PgSearch::Model

  pg_search_scope :search_by_name_and_description,
  against: [ :name, :description ],
  using: {
    tsearch: { prefix: true }
  }
end
