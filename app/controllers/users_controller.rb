class UsersController < ApplicationController
  skip_before_filter :require_no_authentication, :only => [:new, :create]
  def new
     @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
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

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

    # PUT /workshops/1
  # PUT /workshops/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  protected

  def require_no_authentication
      if current_user.role == "Admin"
          return true
      else
          return super
      end
  end
end
