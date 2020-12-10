class UserController < ApplicationController
    get '/users/new' do
        erb :"users/new"
    end
    get '/login' do 
        # redirect_if_not_logged_in
        erb :"/users/login"
    end
    get '/users/:id' do
        @user = User.find_by_id(params[:id])
        # if @user != current_user
        # ### insert error here
        # else
          erb :"/apppointments/show"
    end

    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            redirect "/login"
        end
    end

    post "/users/new" do  
        user = User.new(username: params[:username], password: params[:password], first_name: params["first name"], last_name: params["last name"])
        if user.username.blank? || user.password.blank? || user.first_name.blank? || user.last_name.blank? || User.find_by_username(params["username"])
           redirect "/users/#{user.id}"
        else
            user.save 
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
        end
        
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
