class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
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

  def app_params
    params.permit(:status, :description)
  end
end
