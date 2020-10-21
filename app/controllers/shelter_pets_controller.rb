class ShelterPetsController < ApplicationController

  def index
    @shelter = Shelter.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    shelter.pets.create!(pet_params)
    redirect_to "/shelters/#{shelter.id}/pets"
  end


  def destroy
    shelter = Shelter.find(params[:id])
    pet = Pet.find(params[:petid])
    if pet.apps_approved?
      flash[:notice] = "Cannot delete pet with an approved application."
      redirect_to "/shelters/#{shelter.id}/pets"
    else
      Pet.destroy(params[:petid])
      redirect_to "/pets"
    end
  end

  private
  def pet_params
    params.permit(:image || "", :name, :description, :approx_age, :sex)
  end
end
