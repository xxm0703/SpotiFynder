require 'bcrypt'

class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :update_user, only: %i[ index ]
  include BCrypt
  # GET /users or /users.json
  def index
  end

  # GET /users/login
  def login
    @user = User.new
  end
  
  # GET /users/login
  def logout
    @user = nil
    cookies.delete :user_id
    redirect_to root_path
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def spotify
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

    @user = User.find_by spotify_id: @spotify_user.id

    if @user.nil?
      @user = User.new
      @user.spotify_id = @spotify_user.id
      render new_user_path
    else
      cookies.encrypted[:user_id] = { value: @user.id, expires: Time.now + 3600}
      if params[:callback_address].nil?
        redirect_to profile_path
      else
        redirect_to params[:callback_address]
      end
    end
  end

  def authenticate
    user = user_params
    @user = User.find_by username: user[:username]

    unless @user.nil?
      db_pass = Password.new @user.password_digest
      if db_pass == user[:password]
        cookies.encrypted[:user_id] = { value: @user.id, expires: Time.now + 3600}
        if params[:callback_address].nil?
          redirect_to profile_path
        else
          redirect_to params[:callback_address]
        end
      end
    end
    @user = User.new
    @user.errors.add(:base, 'Invalid credentials')
    render :login
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      update_user
      return unless @user.nil?

      redirect_to login_user_path, status: :unauthorized, callback_address: request.path
    end

    def update_user
      session_user = cookies.encrypted[:user_id]
      @user = session_user ? User.find(session_user) : nil
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user)
            .permit(:username, :password, :password_confirmation, :spotify_id)
    end
end
