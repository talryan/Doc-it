# class AppointmentController < ApplicationController
#     get '/appointments' do 
#         @appointments = Appointment.all
#         erb :"appintments/show" 
#     end

#     # view the form to CREATE a movie 
#     get '/appointments/new' do 
#         # display the new view 
#         if !logged_in? 
#             redirect '/login'
#         end
#         erb :"appointments/new"
#     end

#     get '/appointments/:id' do
#         redirect_if_not_logged_in
#         @appointment = Appointment.find(params["id"])
#         erb :"appointments/show"
#     end

#     post '/appointments' do 
#         redirect_if_not_logged_in
#         appointments = current_user.appointments.build(params)
#         appointment.save 
#         redirect '/appointments'
#     end

#     # view the form to UPDATE 1 particular movie
#     get '/appointments/:id/edit' do
#         @appointment = Appointment.find(params["id"])
#         redirect_if_not_authorized
#         erb :"appointments/edit"
#     end

#     # UPDATE 1 appointment based on the edit form 
#     put '/appointments/:id' do
#         @appointment = Appointment.find(params["id"]) 
#         redirect_if_not_authorized
#         # @appointment.update(title: params["appointment"]["title"])
#         @appointment.update(params["appointment"])
#         redirect "/appointments/#{@appointment.id}"
#     end

#     delete '/appointments/:id' do 
#         @appointment = Appointment.find(params["id"])
#         redirect_if_not_authorized
#         @appointment.destroy
#         redirect '/appointments'
#     end

#     private 
#     def redirect_if_not_authorized
#         if @movie.user != current_user
#             redirect '/appointments'
#         end
#     end
# end