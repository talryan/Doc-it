require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, 'secretsecretigotasecret'
  end

  get "/" do
    erb :welcome
  end

  
  not_found do
  status 404
  erb :error
  end

  helpers do 

    def logged_in?
        !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

  def redirect_if_not_logged_in
    if !logged_in?
      flash[:message] = "Login Failed. Try again."
      redirect "/login"
    end
  end
  private

  def unauthorized
    if @appointment.user != current_user
      redirect "/appointments"
    end
  end
  
end