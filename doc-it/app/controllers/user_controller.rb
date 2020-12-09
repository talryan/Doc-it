class UserController < ApplicationController
    get '/signup' do
        erb :"users/new"
    end

    post "/signup" do  
        user = User.new(username: params[:username], password: params[:password], first_name: params["first name"], last_name: params["last name"])
        if user.username.blank? || user.password.blank? || user.first_name.blank? || user.last_name.blank? || User.find_by_username(params["username"])
           redirect '/signup'
        else
            user.save 
            session[:user_id] = user.id
        end
        
    end

    get '/login' do 
        erb :"/users/login"
    end

    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
    #   redirect "/users/#{@user.id}"
        else
            flash[:message] = "Invalid entry. Try again, please!"
            redirect '/users/login'
        end
    end

    get '/logout' do 
        session.delete(:user_id)
        redirect '/signup'
    end
end