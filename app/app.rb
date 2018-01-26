ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'

class Bookmark < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  register Sinatra::Flash

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    erb :index
  end

  get '/links' do
    @links = Link.all
    erb :links
  end

  get '/links/new' do
    erb :new
  end

  post '/post_links' do
    link = Link.create(title: params[:title], url: params[:url])
    params[:tags].split.each do |tag|
      link.tags << Tag.first_or_create(name: tag)
    end
    link.save
    redirect '/links'
  end

  get '/tags' do
    @links = Link.all
    erb :tags
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :links
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.new(email: params[:email], password: params[:password],
    password_confirmation: params[:password_confirmation])
    if @user.save
    session[:user_id] = @user.id
    redirect '/'
    else
      flash.now[:notice] = 'Password and confirmation password do not match'
      erb :'/users/new'
    end
  end

end
