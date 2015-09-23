HelenaAdministration::ApplicationController.class_eval do
  before_action :authenticate_user!
end
