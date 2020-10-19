class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = Pet.where("name ILIKE :name", name: "%#{params[:pet_name]}%")
  end

  def create
    user = User.find_by(name: params[:user_name])
    if user
      application = user.applications.create(app_params)
      application[:status] = "In Progress"
      application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Please enter an existing user name."
      redirect_to "/applications/new"
    end
  end

  def update
    application = Application.find(params[:id])
    if params[:pet]
      pet = Pet.find(params[:pet])
      application.pets << pet
    elsif params[:description].empty?
      flash[:notice] = "You must enter a description."
    else
      application[:description] = params[:description]
      application[:status] = "Pending"
      application.update(app_params)
    end
    redirect_to "/applications/#{application.id}"
  end

  def app_params
    params.permit(:status, :description)
  end
end
