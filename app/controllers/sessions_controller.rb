class SessionsController < ApplicationController

    def new
    end

    def create 
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:notice] = (session[:lang].nil? or session[:lang] == 'gr')? "Επιτυχής σύνδεση" : "Logged in successfully"
            redirect_to root_path
        else
            flash.now[:alert] = (session[:lang].nil? or session[:lang] == 'gr')? "Λάθος στοιχεία, προσπάθησε ξανά!" : "Wrong credentials! Try again!"
            render 'new'    
        end  
    end

    def destroy 
        session[:user_id] = nil
        flash[:notice] = (session[:lang].nil? or session[:lang] == 'gr')? "Επιτυχής αποσύνδεση" : "Logged out successfully"
        redirect_to root_path
    end

    def language_update
        session[:lang] = params[:session][:lang]
        if session[:lang] == 'en' 
            flash[:notice] = "Language set to English"
            redirect_to request.referrer
        else
            flash[:notice] = "Επιλεγμένη γλώσσα Ελληνικά"
            redirect_to request.referrer
        end
    end

end