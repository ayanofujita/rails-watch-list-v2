class Movie < ApplicationRecord
  has_and_belongs_to_many :lists
  has_and_belongs_to_many :genres
  validates :title, :overview, :poster_url, :rating, presence: true
  validates :title, uniqueness: true

  def better_runtime
    hour = self.runtime / 60
    if hour
      return "#{hour}h #{self.runtime % 60}m"
    else
      return "#{self.runtime}m"
    end
  end

  def genres_and_runtime
    if self.genres.any?
      genres = self.genres.map {|genre| genre.name}.join(", ")
    end

    if genres && self.runtime
      return "#{genres} • #{self.better_runtime}"
    elsif genres
      return genres
    elsif self.runtime
      return self.better_runtime
    else
      return
    end
  end
end
