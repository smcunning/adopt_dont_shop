class ShelterReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    user = User.find_by(name: params[:user_name])
    shelter = Shelter.find(params[:id])
    review = shelter.reviews.new(review_params)
    review.user = user
    if user.nil?
      flash[:notice] = "Not a valid User: Please enter the name of a registered user."
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    elsif review.valid?
      review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = "Please fill out title, rating, and content to submit review"
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end

  def review_params
    params.permit(:title, :rating, :content, :image)
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      image: params[:image]
      })
      review.save
    redirect_to "/shelters/#{review.shelter.id}"
  end

  def destroy
    review = Review.find(params[:review_id])
    shelter = review.shelter.id
    review.destroy
    redirect_to "/shelters/#{shelter}"
  end
end
