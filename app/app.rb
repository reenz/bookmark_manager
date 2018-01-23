require 'sinatra'
require_relative './models/link'

class Bookmark < Sinatra::Base

  get '/' do
    "Welcome"
  end

  get '/links' do
    @links = Link.all
    erb :index
  end

  get '/links/new' do
    erb :new
  end

  post '/post_links' do
    Link.create(title: params[:title], url: params[:url])
    redirect '/links'
  end
end
