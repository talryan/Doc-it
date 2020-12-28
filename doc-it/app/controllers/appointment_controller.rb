class AppointmentController < ApplicationController
    
    get '/appointments' do 
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
        @appointment = Appointment.find(params[:id]) 
        erb :"appointments/show"
    end

    post '/appointments' do 
        redirect_if_not_logged_in
        appointment = Appointment.create(date: params[:date], time: params[:time], doctor_name: params[:doctor_name])
        if appointment.date.blank? || appointment.time.blank? || appointment.doctor_name.blank?
            flash[:message] = 'One or more fields left empty.Try Again.'
            redirect"appointments/new"
        end
        appointment.user_id = session[:user_id]
        appointment.save
        redirect "/appointments/#{appointment.id}"
    end

    get '/appointments/:id/edit' do
        @appointment = Appointment.find(params[:id])
        unauthorized
        #  if @appointment.date.blank?|| @appointment.time.blank?|| @appointment.doctor_name.blank?
        # flash[:message] = 'Try Again.'

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
    
    private

    def unauthorized
      if @appointment.user != current_user
        redirect "/appointments"
      end
    end

   
end
