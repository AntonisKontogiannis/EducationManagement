class SemestersController < ApplicationController
    before_action :set_semester, only: %i[ edit update destroy ]
    before_action :require_user
    before_action :require_admin

    def new
    end

    def create
        @semester = Semester.new(semester_params)
        respond_to do |format|
            if @semester.save
                format.html { redirect_to root_path, notice: (session[:lang].nil? or session[:lang] == 'gr')? "Επιτυχής δημιουργία εξαμήνου" : "Semester was successfully created." }
                format.json { render :show, status: :created, location: @semester }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @semester.errors, status: :unprocessable_entity }
            end
        end
    end

    def delete
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_semester
      @semester = Semester.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def semester_params
      params.require(:semester).permit(:en_title, :gr_title)
    end

    def require_admin
        if @current_user.nil? or @current_user.role != 'Admin'
            respond_to do |format|
                format.html { redirect_to root_path, notice: (session[:lang].nil? or session[:lang] == 'gr')? "Πρέπει να είσαι διαχειριστής για να κάνεις αυτή την ενέργεια" : "You must be an admin to do this" }
            end
        end
    end
end
