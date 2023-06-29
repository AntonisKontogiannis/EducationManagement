class PagesController < ApplicationController  
    before_action :require_user

    def home
        if @current_user.role == 'Admin'
            redirect_to control_panel_path
        end
    end

    def control_panel
        if @current_user.role != 'Admin'
            redirect_to root_path
        else
            @semesters = Semester.all.sort_by {|s| s.id}
            @subjects = Subject.all
            @students = User.all.where(role: 'Student')
            @professors = User.all.where(role: 'Professor')
        end
    end

    def admin_settings
        if @current_user.role != 'Admin'
            redirect_to root_path
        else
            @settings = GlobalSetting.all
        end
    end
end
