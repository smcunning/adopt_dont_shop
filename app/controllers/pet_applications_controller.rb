class PetApplicationsController < ApplicationController

  def index
    @pet = Pet.find(params[:id])
  end

  private
  def pet_params
    params.permit(:pet_id)
  end
end
