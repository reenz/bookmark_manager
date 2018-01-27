class Bookmark < Sinatra::Base

  get '/tags' do
    @links = Link.all
    erb :tags
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :links
  end
end
