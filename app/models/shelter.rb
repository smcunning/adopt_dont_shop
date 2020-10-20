class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates_presence_of :name, :address, :city, :state, :zip

  def pets_count
   self.pets.count
 end

 def average_rating
   (self.reviews.sum {|review| review.rating}).to_f / self.reviews.count
 end

 def application_count
   self.pets.sum do |pet|
     pet.applications.count
   end
 end
end
