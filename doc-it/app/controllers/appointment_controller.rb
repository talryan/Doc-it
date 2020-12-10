class AppointmentController < ApplicationController
    get '/appointments' do 
        @appointments = Appointment.all
        erb :"appointments/show" 
    end
    post '/appointments' do 
        redirect_if_not_logged_in
        appointments = current_user.appointments.build(params)
        appointment.save 
        redirect '/appointments'
    end

    get '/appointments/new' do 
        erb :"appointments/new"
    end

    get '/appointments/:id' do
        redirect_if_not_logged_in
        @appointment = Appointment.find(params["id"])
        erb :"appointments/show"
    end


    get '/appointments/:id/edit' do
        @appointment = Appointment.find(params["id"])
        redirect_if_not_authorized
        erb :"appointments/edit"
    end


    put '/appointments/:id' do
        @appointment = Appointment.find(params["id"]) 
        redirect_if_not_authorized
        @appointment.update(params["appointment"])
        redirect "/appointments/#{@appointment.id}"
    end

    delete '/appointments/:id' do 
        @appointment = Appointment.find(params["id"])
        redirect_if_not_authorized
        @appointment.destroy
        redirect '/appointments'
    end

    private 
    def redirect_if_not_authorized
        if @appointment.user != current_user
            redirect '/appointments'
        end
    end
end