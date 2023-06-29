class GlobalSettingsController < ApplicationController  
    before_action :require_user
    before_action :require_admin

    def update
        setting = GlobalSetting.find(params[:global_setting][:id])
        setting.update_column(:value,params[:global_setting][:value])
        respond_to do |format|
            format.html { redirect_to admin_settings_path, notice: (session[:lang].nil? or session[:lang] == 'gr')? "Επιτυχής ρύθμιση" : "Setting was successfully updated." }
        end
    end

    private

    def require_admin
        if @current_user.nil? or @current_user.role != 'Admin'
            respond_to do |format|
                format.html { redirect_to root_path, alert: (session[:lang].nil? or session[:lang] == 'gr')? "Πρέπει να είσαι διαχειριστής για να μπεις σε αυτό το μενού" : "You must be an admin to enter this menu." }
            end
        end
    end
end