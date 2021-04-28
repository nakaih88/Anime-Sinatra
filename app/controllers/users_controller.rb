class UsersController < ApplicationController

    get '/login' do
        puts flash
        erb :login
    end

    post '/login' do
        if params[:username] == "" || params[:password] == ""
            flash[:message] = "Username or password not found. Please try again."
            redirect '/login'
        end
        @user = User.find_by(username: params[:username])
        if @user != nil && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "users/#{@user.id}"
        else
            flash[:message] = "Username or password not found. Please try again."
            redirect '/login'
        end
    end

    get '/signup' do
        erb :signup
    end

    post '/users' do
        @potential_user = User.find_by(username: params[:username])
        if @potential_user == nil
            if params[:username] != "" && params[:password] != ""
                @user = User.create(params)
                session[:user_id] = @user.id
                redirect "users/#{@user.id}"
            else
                flash[:message] = "Your inputs were invalid."
                redirect '/signup'
            end
        else
            flash[:message] = "This username already exists. Please try a new one."
            redirect '/signup'
        end
    end

    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        erb :show
    end

    get '/logout' do
        session.clear
        redirect '/'
    end
end