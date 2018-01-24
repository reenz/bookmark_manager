ENV["RACK_ENV"] ||= "development"

require 'sinatra'
require_relative './models/link'
require_relative './models/tag'
require_relative './app/data_mapper_setup'

class Bookmark < Sinatra::Base

  get '/' do
    erb :welcome
  end

  get '/links' do
    @links = Link.all
    erb :index
  end

  get '/links/new' do
    erb :new
  end

  post '/post_links' do
    link = Link.new(title: params[:title], url: params[:url])
    tag = Tag.first_or_create(name: params[:tag])
    link.tags << tag
    link.save
    redirect '/links'
  end
end
