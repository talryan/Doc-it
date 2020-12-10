require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    # register Sinatra::Flash
    set :session_secret, 'secretsecretigotasecret'
  end

  get "/" do
    redirect_if_not_logged_in
    erb :welcome
  end

  helpers do 

    def logged_in?
        !!current_user
    end

    def current_user
      @current_user ||=  User.find(session[:user_id]) if session[:user_id]
    end
  end
  def redirect_if_not_authorized
    redirect '/welcome' if @appointment.user != current_user
  end

  # def redirect_if_not_logged_in
  #  if !logged_in?
    
  #  end
end