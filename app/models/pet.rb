class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications
  validates_presence_of :name, :approx_age, :sex

  def find_pet_application(application_id)
    pet_applications.find_by(application_id: application_id)
  end
end
