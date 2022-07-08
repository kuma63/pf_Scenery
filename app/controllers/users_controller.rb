class UsersController < ApplicationController

def show
end

def edit
 @user = User.find(params[:id])
end

def update
 @user = User.find(params[:id])
 @user = User.update(user_params)
 redirect_to photos_path
end

def withdrawal
end

private

def user_params
 params.require(:user).permit(:profile_image, :name, :nickname, :email, :is_deleted, :is_admin)
end

end
