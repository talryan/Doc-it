class UserController < ApplicationController
    get '/users' do 
        erb :'/users/index'
    end

    get '/signup' do
        erb :"users/new"
    end

    post "/signup" do  
        user = User.new(username: params[:username], password: params[:password], first_name: params["first name"], last_name: params["last name"])
        # user = User.new(params)
        # if params.values.any?{|value| value.blank?} || User.find_by_username(params[:username])
        if user.username.blank? || user.password.blank? || user.first_name.blank? || user.last_name.blank? || User.find_by_username(params["username"])
           redirect "/signup"
  
        else
            user.save 
            flash[:message] = "Success! Please login now."
            session[:user_id] = user.id
            
            redirect "/users/#{user.id}"
        end
        
    end
    get '/login' do 
        # redirect_if_not_logged_in
        erb :"/users/login"
    end

    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:message] = "Log in successful."
            redirect '/users'
            # redirect "/users/#{@user.id}"
        else
            redirect "/login"
        end
    end


    get "/users/:id" do
        @users = User.find(params["id"]) 
        erb :"/appointments"
    end

    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
         session[:user_id] = @user.id
         redirect "/appointments"
        end
    end

    get '/logout' do
        session.clear
        redirect '/'
      end

end  
