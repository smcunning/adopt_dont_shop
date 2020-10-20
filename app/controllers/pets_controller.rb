class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
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

  def destroy
    pet = Pet.find(params[:id])
    if pet.apps_approved?
      flash[:notice] = "Cannot delete pet with an approved application."
      redirect_to "/pets/#{pet.id}"
    else
    Pet.destroy(params[:id])
    redirect_to '/pets'
    end
  end
end
