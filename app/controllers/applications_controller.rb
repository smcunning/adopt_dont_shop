class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = Pet.where(name: params[:pet_name])
  end

  def new
  end

  def create
    user = User.find_by(name: params[:user_name])
    if user
      app = user.applications.create(app_params)
      app[:status] = "In Progress"
      app.save
      redirect_to "/applications/#{app.id}"
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
