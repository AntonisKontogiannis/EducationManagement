class SubjectsController < ApplicationController
  before_action :require_user
  before_action :set_subject, only: %i[ show edit update destroy ]
  before_action :require_admin_or_professor, only: %i[new create edit update destroy ]

  # GET /subjects or /subjects.json
  def index
    redirect_to control_panel_path if @currrent_user.role == "Administrator"
    @user_attends = @current_user.subject_attends.pluck(:subject_id)
    @subjects = Subject.all
    @subject_attend = SubjectAttend.new
    @semesters  = Semester.all
  end

  # GET /subjects/1 or /subjects/1.json
  def show
    @subject_attends = @subject.subject_attends
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
  end

  # POST /subjects or /subjects.json
  def create
    @subject = Subject.new(subject_params)

    respond_to do |format|
      if @subject.save
        format.html { redirect_to root_path, notice: (session[:lang].nil? or session[:lang] == 'gr')? "Επιτυχής δημιουργία μαθήματος" : "Subject was successfully created." }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1 or /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to subject_url(@subject), notice: (session[:lang].nil? or session[:lang] == 'gr')? "Επιτυχής ανανέωση μαθήματος" : "Subject was successfully updated." }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1 or /subjects/1.json
  def destroy
    @subject.destroy

    respond_to do |format|
      format.html { redirect_to subjects_url, notice: (session[:lang].nil? or session[:lang] == 'gr')? "Επιτυχής διαγραφή μαθήματος" : "Subject was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subject_params
      params.require(:subject).permit(:title, :semester_id)
    end

    # Only allow authored users to create/update/destroy.
    def require_admin_or_professor
      if @current_user.nil? or @current_user.role == 'Student'
        respond_to do |format|
            format.html { redirect_to root_path, notice: (session[:lang].nil? or session[:lang] == 'gr')? "Πρέπει να είσαι διαχειριστής ή καθηγητής για να μπεις σε αυτό το μενού" : "You must be an admin or a professor to do this" }
        end
      end
  end
end
