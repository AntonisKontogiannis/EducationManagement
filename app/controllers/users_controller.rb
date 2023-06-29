class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_user, except: [:show, :new, :create, :index]
  before_action :require_same_user_or_admin, only: [:edit, :update, :destroy]

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice:  (session[:lang].nil? or session[:lang] == 'gr')? "Επιτυχής δημιουργία χρήστη" : "User was successfully created." }
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
        format.html { redirect_to root_path, notice: (session[:lang].nil? or session[:lang] == 'gr')? "Επιτυχής ανανέωση χρήστη" : "User was successfully updated." }
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
      format.html { redirect_to root_path, notice: (session[:lang].nil? or session[:lang] == 'gr')? "Επιτυχής διαγραφή χρήστη" : "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:avatar, :first_name, :last_name, :email, :password, :role)
    end

    def require_same_user_or_admin
      if @current_user != @user
        flash[:alert] = (session[:lang].nil? or session[:lang] == 'gr')? "Δεν είσαι εξουσιοδοτημένος για αυτό." : "You don't have the authority to do this!"
        redirect_to root_path
      end
  end
end
