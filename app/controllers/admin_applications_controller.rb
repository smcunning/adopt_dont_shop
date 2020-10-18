class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(params[:id])
    application[:status] = "Approved"
    application.save
    redirect_to "/admin/applications/#{application.id}"
  end
end
