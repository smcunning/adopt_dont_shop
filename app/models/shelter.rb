class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates_presence_of :name, :address, :city, :state, :zip

  def pets_count
   pets.count
 end

 def average_rating
   (reviews.sum {|review| review.rating}).to_f / self.reviews.count
 end

 def application_count
   pets.sum do |pet|
     pet.applications.count
   end
 end

 def any_pets_approved?
   pets.any? do |pet|
    pet.apps_approved?
  end
 end
end
