class ShelterReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    if User.where(:name => params[:user]).empty?
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    else
      shelter.reviews.create!(review_params)
      redirect_to "/shelters/#{shelter.id}"
    end
  end

  def review_params
    params.permit(:title, :rating, :content, :user, :image)
  end
end
