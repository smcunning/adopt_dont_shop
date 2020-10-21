class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def apps_approved?
    applications.exists?(status: "Approved")
  end
end
