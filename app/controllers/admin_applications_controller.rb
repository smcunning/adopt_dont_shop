class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(params[:id])
    if params[:status] == "Approved"
      application[:status] = "Approved"
      application.save
    elsif params[:status] == "Denied"
      application[:status] = "Denied"
      application.save
    end
    redirect_to "/admin/applications/#{application.id}"
  end
end
