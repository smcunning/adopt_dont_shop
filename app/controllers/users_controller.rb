class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @reviews = Review.where(:user_id => @user.id)
    @best_review = @user.best_review
    @worst_review = @user.worst_review
  end

  def new
  end

  def create
    user = User.new({
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip]
      })
      user.save
      redirect_to "/users/#{user.id}"
  end
end
