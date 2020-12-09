class UserController < ApplicationController
    get '/users/new' do
        erb :"users/new"
    end
    get '/login' do 
        erb :"/users/login"
    end
    get '/users/:id' do
        @user = User.find_by_id(params[:id])
        if @user != current_user
        else
          erb :"/users/show"
        end
    end

    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            redirect "/users/login"
        end
    end

    post "/users/new" do  
        user = User.new(username: params[:username], password: params[:password], first_name: params["first name"], last_name: params["last name"])
        if user.username.blank? || user.password.blank? || user.first_name.blank? || user.last_name.blank? || User.find_by_username(params["username"])
           redirect '/users/show'
        else
            user.save 
            session[:user_id] = user.id
        end
        
    end

    # get '/login' do 
    #     erb :"/users/login"
    # end

    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
         session[:user_id] = @user.id
         redirect "/appointments/show"
        end
    end


end  
