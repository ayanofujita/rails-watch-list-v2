class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  validates :username, length: { maximum: 16 }
  validates :username, presence: true
  has_one_attached :photo
  acts_as_favoritor
  has_many :lists

  def favorite_lists
    favorites_by_type('List').map do |favorite|
      List.find(favorite.favoritable_id)
    end
  end
end
