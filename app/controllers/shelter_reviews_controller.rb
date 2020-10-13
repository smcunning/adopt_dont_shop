class ShelterReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    shelter.reviews.create!(review_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  def review_params
    params.permit(:title, :rating, :content, :user, :image)
  end
end
