class ContentsController < ApplicationController
  before_action :require_user
  before_action :set_content, only: %i[ show edit update destroy ]

  # GET /contents/new
  def new
    @content = Content.new
    @subject = Subject.find(params[:subject_id])
  end

  # GET /contents/1/edit
  def edit
    @subject = Subject.find(params[:subject_id])
  end

  # POST /contents or /contents.json
  def create
    @content = Content.new(content_params)
    @subject = Subject.find(@content.subject_id)
    respond_to do |format|
      if @content.save
        format.html { redirect_to subject_path(@content.subject_id), notice: (session[:lang].nil? or session[:lang] == 'gr')? "Το υλικό δημιουργήθηκε με επιτυχία." : "Content was successfully created." }
        format.json { render :show, status: :created, location: @content }
      else
        format.html { redirect_to new_content_path(subject_id: @subject.id), alert: (session[:lang].nil? or session[:lang] == 'gr')? "Το υλικό δεν δημιουργήθηκε." : "Content was not created."}
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contents/1 or /contents/1.json
  def update
    respond_to do |format|
      if @content.update(content_params)
        format.html { redirect_to content_url(@content), notice: (session[:lang].nil? or session[:lang] == 'gr')? "Το υλικό ανανεώθηκε με επιτυχία." : "Content was successfully updated." }
        format.json { render :show, status: :ok, location: @content }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1 or /contents/1.json
  def destroy
    @content.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: (session[:lang].nil? or session[:lang] == 'gr')? "Το υλικό διαγράφηκε με επιτυχία." : "Content was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def content_params
      params.require(:content).permit(:title, :subject_id, :url, :file, :image, :description)
    end
end
