class UserController < ApplicationController
    get '/users' do 
        erb :'/users/index'
    end

    get '/signup' do
        erb :"users/new"
    end

    post "/signup" do  
        user = User.new(params)
        if user.username.blank? || user.password.blank? || user.first_name.blank? || user.last_name.blank? || User.find_by_username(params["username"])
            flash[:message] = 'Try Again.'
            redirect "/signup"
        elsif
         User.find_by_username(params['username'])

        redirect '/'
        else
            user.save 
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
            
        end
        
    end
    get '/login' do 
        erb :"/users/login"
    end

    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:message] = "Log in successful."
            redirect '/users'
        else
            flash[:message] = "Entry Invalid. Try Again."
            redirect_if_not_logged_in
            redirect "/login"
        end
    end

    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
         session[:user_id] = @user.id
         redirect "/user/index"
        end
    end

    get "/users/:id" do
        redirect_if_not_logged_in
        @user = User.find(params["id"]) 
        erb :"/appointments/index"
    end

    get '/logout' do
        session.clear
        redirect '/'
      end

end  
