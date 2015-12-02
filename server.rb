module App
  class Server < Sinatra::Base
    set :method_override, true
    enable :sessions

    get "/" do
      @user = User.find(session[:user_id]) if session[:user_id]
      erb :index
    end

    get "/login" do 
      erb :login
    end

    post "/sessions" do 
      user = User.find_by({username: params[:username]})
      session[:user_id] = user.id
      redirect to "/"
    end

    get "/signup" do 
      erb :signup
    end

    post "/users" do 
      user = User.create({username: params[:username], password: params[:password], email: params[:email]})
      redirect to "/users/#{user.id}"
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

    get "/users" do 
      @users = User.all
      erb :users
    end

    get "/users/:id" do 
      @user = User.find(params[:id])
      erb :user
    end

  end # Server
end # App