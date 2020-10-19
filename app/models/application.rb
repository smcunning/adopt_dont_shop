class Application < ApplicationRecord
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def all_pet_apps_approved?
    self.pet_applications.all?{|pet_application| pet_application.status == "Approved"}
  end

  def any_pet_apps_denied?
    self.pet_applications.any?{|pet_application| pet_application.status == "Denied"}
  end
end
