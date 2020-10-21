class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :applications, through: :pets

  def pets_count
    pets.count
  end

  def average_rating
    reviews.average(:rating)
  end

  def application_count
    pets.joins(:applications).count
  end
end
