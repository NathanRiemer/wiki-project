module App
  class Server < Sinatra::Base
    set :method_override, true
    enable :sessions

    get "/" do
      erb :index
    end

    get "/articles" do
      @articles = Article.all
      erb :articles
    end

    get "/articles/:id" do 
      @article = Article.find(params[:id])
      erb :article
    end

    get "/articles/:id/revisions" do 
      @article = Article.find(params[:id])
      erb :revisions
    end

    get "/articles/:id/revisions/:rev_id" do 
      @revision = Revision.find(params[:rev_id])
      erb :revision
    end



  end # Server
end # App