class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?
 # destroyアクションの前にメールアドレスがゲストユーザー用になっていないか確認する
 # before_action :check_guest, only: [:update, :destroy]

 # def check_guest
    # if resource.email == 'zzz@zzz'
      # redirect_to root_path, alert: 'ゲストユーザーは更新・ログアウトできません。'
    # end
 # end

  # ゲストログイン
  def new_guest
   user = User.guest
   sign_in user
   redirect_to photos_path
  end

 def after_sign_in_path_for(resource)
   photos_path
 end

 def after_sign_out_path_for(resource)
   root_path
 end

 protected

 # 退会後のログインを阻止する

 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname, :is_deleted, :is_admin])
 end


end
