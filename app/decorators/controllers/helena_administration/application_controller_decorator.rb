HelenaAdministration::ApplicationController.class_eval do
  def can_administer?
    current_user if current_user
  end
end
