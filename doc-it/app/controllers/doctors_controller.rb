class DoctorsController < ApplicationController

  # GET: /doctors
  get "/doctors" do
    if logged_in?
      @user = current_user 
    erb :"/doctors/index"
  end

  # GET: /doctors/new
  get "/doctors/new" do
    erb :"/doctors/new"
  end

  # POST: /doctors
  post "/doctors" do
    doctor = Doctor.create(name: params[:name])
    if doctor.name.blank?
        redirect"doctors/new"
  end
  appointment.user_id = session[:user_id]
  doctor.save
  redirect "/appointments/#{appointment.id}

  # GET: /doctors/5
  get "/doctors/:id" do
    erb :"/doctors/show.html"
  end

  # GET: /doctors/5/edit
  get "/doctors/:id/edit" do
    erb :"/doctors/edit.html"
  end

  # PATCH: /doctors/5
  patch "/doctors/:id" do
    redirect "/doctors/:id"
  end

  # DELETE: /doctors/5/delete
  delete "/doctors/:id/delete" do
    redirect "/doctors"
  end
end
