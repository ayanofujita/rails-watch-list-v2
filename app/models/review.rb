class Review < ApplicationRecord
  belongs_to :user
  belongs_to :list
  validates :rating, numericality: { only_integer: true, in: 0..5 }
end
