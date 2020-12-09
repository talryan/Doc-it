class AppointmentController < ApplicationController
    get '/appointments' do 
        @appointments = Appointment.all
        erb :"appintments/show" 
    end

    # view the form to CREATE a movie 
    get '/appointments/new' do 
        # display the new view 
        if !logged_in? 
            redirect '/login'
        end
        erb :"appointments/new"
    end

    get '/appointments/:id' do
        redirect_if_not_logged_in
        @appointment = Appointment.find(params["id"])
        erb :"appointments/show"
    end

    post '/appointments' do 
        redirect_if_not_logged_in
        appointments = current_user.appointments.build(params)
        appointment.save 
        redirect '/movies' # makes a new GET request 
    end

    # view the form to UPDATE 1 particular movie
    get '/movies/:id/edit' do
        @movie = Movie.find(params["id"])
        redirect_if_not_authorized
        erb :"movies/edit"
    end

    # UPDATE 1 movie based on the edit form 
    put '/movies/:id' do
        @movie = Movie.find(params["id"]) 
        redirect_if_not_authorized
        # @movie.update(title: params["movie"]["title"])
        @movie.update(params["movie"])
        redirect "/movies/#{@movie.id}"
    end

    delete '/movies/:id' do 
        @movie = Movie.find(params["id"])
        redirect_if_not_authorized
        @movie.destroy
        redirect '/movies'
    end

    private 
    def redirect_if_not_authorized
        if @movie.user != current_user
            redirect '/movies'
        end
    end
end