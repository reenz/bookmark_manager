class Bookmark < Sinatra::Base

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
end
