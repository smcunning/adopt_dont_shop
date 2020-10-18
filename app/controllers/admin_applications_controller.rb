class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def update
    pet_app = PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:id])
    pet_app.update(status: params[:status])
    application = Application.find(params[:id])
    if application.pet_applications.all?{|pet_application| pet_application.status == "Approved"}
      application[:status] = "Approved"
      application.pets.each do |pet|
         pet.adoptable = false
         pet.save
       end
      application.save
    elsif application.pet_applications.any?{|pet_application| pet_application.status == "Denied"}
      application[:status] = "Denied"
      application.save
    end
    redirect_to "/admin/applications/#{application.id}"
  end
end
