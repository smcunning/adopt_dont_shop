class PetApplicationsController < ApplicationController

  def index
    require "pry"; binding.pry
    @applications = Application.all
  end

  private
  def pet_params
    params.permit(:pet_id)
  end
end
