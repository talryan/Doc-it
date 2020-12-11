class AppointmentController < ApplicationController
    
    get '/appointments' do  #This displays index of appointments
        if logged_in?
        @appointments = Appointment.all
        erb :"/appointments/index"
        else 
        redirect "/"
        end
    end

    get '/appointments/new' do 
        erb :'appointments/new'
    end

    get "/appointments/:id" do
        @appointment = Appointment.find(params["id"]) 
       
        erb :"appointments/show"
    end

    post '/appointments' do 
        # redirect_if_not_logged_in
        @appointment = Appointment.create(date: params[:date], time: params[:time], patient_name: params[:patient_name])
        @appointment.user_id = session[:user_id]
        @appointment.save
        redirect "/appointments"
    end
    get '/appointments/:id/edit' do
      
        @appointment = Appointment.find(params[:id])
        # redirect_if_not_authorized
        erb :"appointments/edit"
    end

    patch '/appointments/:id' do
        binding.pry
        @appointment = Appointment.find_by_id(params[:id]) 
       
        # redirect_if_not_authorized
        @appointment.update(params["appointments"])
        
        redirect "/appointments/#{@appointment.id}"
    end


    delete '/appointments/:id' do 
        @appointment = Appointment.find_by_id(params["id"])
        # redirect_if_not_authorized
        @appointment.destroy
        redirect '/appointments'
    end
end