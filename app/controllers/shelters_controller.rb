class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
    @reviews = Review.where(:shelter_id => @shelter.id)
  end

  def create
    shelter = Shelter.new({
      name: params[:shelter][:name],
      address: params[:shelter][:address],
      city: params[:shelter][:city],
      state: params[:shelter][:state],
      zip: params[:shelter][:zip]
      })

    shelter.save
    redirect_to '/shelters'
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update({
        name: params[:shelter][:name],
        address: params[:shelter][:address],
        city: params[:shelter][:city],
        state: params[:shelter][:state],
        zip: params[:shelter][:zip]
      })
    shelter.save
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.apps_approved?
      flash[:notice] = "Cannot delete shelter with Approved Pet Applications"
      redirect_to "/shelters/#{shelter.id}"
    else
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    end
  end
end
