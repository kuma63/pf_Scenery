class ApplicationController < ActionController::Base
 before_action :authenticate_user!, except: [:top]
 before_action :configure_permitted_parameters, if: :devise_controller?

 GOOGLE_API_KEY = ENV["API_KEY"]



 def after_sign_in_path_for(resource)
   photos_path
 end

 def after_sign_out_path_for(resource)
   root_path
 end

 protected

 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname, :is_deleted, :is_admin])
 end


end
