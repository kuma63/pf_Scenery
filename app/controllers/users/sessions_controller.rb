class Users::SessionsController < Devise::SessionsController
  
  # ゲストログイン
  def new_guest
   user = User.guest
   sign_in user
   redirect_to photos_path
  end
end