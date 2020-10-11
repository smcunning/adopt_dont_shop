class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    shelter.pets.create(pet_params)
    redirect_to "/shelters/#{shelter.id}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update({
        image: params[:image],
        name: params[:name],
        description: params[:description],
        approx_age: params[:approx_age],
        sex: params[:sex],
        adoptable: true
      })
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  def pet_params
    params.permit(:image, :name, :description, :approx_age, :sex)
  end
end
