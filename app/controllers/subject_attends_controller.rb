class SubjectAttendsController < ApplicationController
  before_action :require_user
  before_action :set_subject_attend, only: %i[ destroy ]
  before_action :authored_users, only: %i[ destroy ]
  before_action :same_user, only: %i[ create ]

  # POST /subject_attends or /subject_attends.json
  def create
    @subject_attend = SubjectAttend.new(subject_attend_params)

    respond_to do |format|
      if @subject_attend.save
        format.html { redirect_to subjects_path, notice: (session[:lang].nil? or session[:lang] == 'gr')? "Επιτυχής συμμετοχή στο μάθημα." : "Subject attend was successfully created." }
        format.json { render :show, status: :created, location: @subject_attend }
      else
        format.html { redirect_to subjects_path, notice: (session[:lang].nil? or session[:lang] == 'gr')? "Δεν μπορείς να παρακολουθήσεις αυτό το μάθημα." : "You can't attend this one!" }
        format.json { render json: @subject_attend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subject_attends/1 or /subject_attends/1.json
  def destroy
    @subject_attend = SubjectAttend.find(params[:id])
    @subject_attend.destroy
    
    flash[:alert] = (session[:lang].nil? or session[:lang] == 'gr')? "Επιτυχής αποχώρηση από το μάθημα." : "Subject attend was successfully destroyed." 
    redirect_to subjects_path
  end

  private
    # Only allow a list of trusted parameters through.
    def subject_attend_params
      params.require(:subject_attend).permit(:user_id, :subject_id)
    end

    def set_subject_attend
      @subject_attend = SubjectAttend.find(params[:id])
    end

    # Only authored users for the actions
    def authored_users
      if @current_user
        if @current_user.role == 'Professor' 
          if @current_user.subject_attends.find_by(subject_id: @subject_attend.subject_id).nil?
            respond_to do |format|
              format.html { redirect_to root_path, notice: (session[:lang].nil? or session[:lang] == 'gr')? "Πρέπει να συμμετέχεις για να κάνεις αυτή την ενέργεια" : "You must attend the subject to do this" }
            end
          end
        elsif @current_user.role == 'Student' 
          if @current_user != @subject_attend.user
            respond_to do |format|
              format.html { redirect_to root_path, notice: (session[:lang].nil? or session[:lang] == 'gr')? "Πρέπει να είσαι ο ίδιος χρήστης για να κάνεις αυτή την ενέργεια" : "You must be the same user to do this" }
            end
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to root_path, notice: (session[:lang].nil? or session[:lang] == 'gr')? "Πρέπει να είσαι συνδεδεμένος για να κάνεις αυτή την ενέργεια" : "You must be logged-in to do this" }
        end
      end
    end

    def same_user
      if @current_user != User.find(params[:subject_attend][:user_id])
        flash[:alert] = (session[:lang].nil? or session[:lang] == 'gr')? "Δεν μπορείς να το κάνεις αυτό." : "You can't do this" 
        redirect_to root_path
      end
    end
end
