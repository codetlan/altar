class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, :only => [:new, :create]
  def update
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      # redirect_to after_update_path_for(@user)
      redirect_to edit_user_registration_path
    else
      render "edit"
    end
  end

   def create
    @user = User.new(params[:user])
    @user.password = Devise.friendly_token[0,20]
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end