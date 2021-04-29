class AnimeEntriesController < ApplicationController

    get '/anime_entries' do
        @all_anime = Anime.all
        erb :'anime_entries/index'
    end

    get '/anime_entries/new' do
        erb :'/anime_entries/new'
    end

    post '/anime_entries' do
        if !logged_in?
            redirect '/'
        end
        if params[:name] != "" && params[:fav_scene] != "" && params[:rating] != ""
            @anime = Anime.create(name: params[:name], fav_scene: params[:fav_scene], rating: params[:rating], user_id: current_user.id)
            redirect "/anime_entries/#{@anime.id}"
        else
            flash[:message] = "Uh oh! You didn't fill out the form entirely!"
            redirect '/anime_entries/new'
        end
    end

    get '/anime_entries/:id' do
        @anime = Anime.find(params[:id])
        erb :'/anime_entries/show'
    end

    get '/anime_entries/:id/edit' do
        @anime = Anime.find(params[:id])
#        if !logged_in? || @anime.user != current_user
#        redirect '/'
#        end
        redirect_if_not_authorized(@anime)
        erb :'/anime_entries/edit'
    end

    patch '/anime_entries/:id' do
        @anime = Anime.find(params[:id])
        if logged_in?
            if @anime.user == current_user && params[:name] != "" && params[:fav_scene] != "" && params[:rating] != ""
                @anime.update(name: params[:name], fav_scene: params[:fav_scene], rating: params[:rating])
                redirect "/anime_entries/#{@anime.id}"
            else
                flash[:message] = "Uh oh! You didn't fill out the form entirely!"
                redirect "/anime_entries/#{@anime.id}/edit"
            end
        else
            redirect '/'
        end
    end

    delete '/anime_entries/:id' do
        @anime = Anime.find(params[:id])
        if logged_in? && @anime.user == current_user
            @anime.destroy
            redirect '/anime_entries'
        else
            redirect '/'
        end
    end
    
end