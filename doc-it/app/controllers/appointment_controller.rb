class AppointmentController < ApplicationController
    
    get '/appointments' do  #This displays index of appointments
        if logged_in?
        @user = current_user 
        erb :"/appointments/index"
        else 
        redirect "/"
        end
    end

    get '/appointments/new' do 
        redirect_if_not_logged_in
        erb :'appointments/new'
    end

    get "/appointments/:id" do
        redirect_if_not_logged_in
        @appointment = Appointment.find(params["id"]) 
        erb :"appointments/show"
    end

    post '/appointments' do 
        redirect_if_not_logged_in
        appointment = Appointment.create(date: params[:date], time: params[:time], patient_name: params[:patient_name], doctor_name: params[:doctor_name])
        if appointment.date.blank?|| appointment.time.blank?|| appointment.patient_name.blank?|| appointment.doctor_name.blank?
            redirect"appointments/new"
        end
        appointment.user_id = session[:user_id]
        appointment.save
        redirect "/appointments/#{appointment.id}"
    end

    get '/appointments/:id/edit' do
        @appointment = Appointment.find(params[:id])
        unauthorized
        erb :"appointments/edit"
    end

    put '/appointments/:id' do
        @appointment = Appointment.find(params[:id]) 
        unauthorized
        @appointment.update(params["appointments"])
        
        redirect "/appointments/#{@appointment.id}"
    end


    delete '/appointments/:id' do 

        @appointment = Appointment.find(params[:id])
        unauthorized
        @appointment.destroy
        redirect "/appointments"
    end

 
end