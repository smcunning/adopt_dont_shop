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

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    user = User.find_by(name: params[:user_name])
    shelter = Shelter.find(params[:id])
    review = Review.find(params[:review_id])
    review.update({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      image: params[:image]
      })
    if user.nil?
      flash[:notice] = "User does not exist, please enter valid user"
      redirect_to "/shelters/#{shelter.id}/reviews/#{review.id}/edit"
    elsif review.valid?
        review.save
        redirect_to "/shelters/#{review.shelter.id}"
    else
      flash[:notice] = "Title, Rating, and Content cannot be blank."
      redirect_to "/shelters/#{shelter.id}/reviews/#{review.id}/edit"
    end
  end

  def destroy
    review = Review.find(params[:review_id])
    shelter = review.shelter.id
    review.destroy
    redirect_to "/shelters/#{shelter}"
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image)
  end

end
