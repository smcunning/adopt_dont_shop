class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications
  validates_presence_of :image, :name, :approx_age, :sex

  def find_pet_application(application_id)
    PetApplication.find_by(pet_id: id, application_id: application_id)
  end

  def apps_pending?
    applications.any? do |app|
      app.status == "Pending"
    end
  end
end
