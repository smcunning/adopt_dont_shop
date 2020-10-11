class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def create
    Pet.create({
      image: params[:image],
      name: params[:name],
      approx_age: params[:approx_age],
      sex: params[:sex],
      shelter_id: params[:shelter_id]
      })
  end
end
