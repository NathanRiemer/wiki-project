module App
  class Server < Sinatra::Base
    set :method_override, true
    enable :sessions
    helpers Sinatra::LinkUtils

    get "/" do
      @user = User.current_user(session)
      erb :index
    end

    get "/login" do 
      erb :login
    end

    post "/sessions" do 
      user = User.find_by({username: params[:username]}).try(:authenticate, params[:password])
      session[:user_id] = user.id
      redirect to "/"
    end

    delete "/sessions" do
      session[:user_id] = nil
      redirect to "/"
    end      

    get "/signup" do 
      erb :signup
    end

    post "/users" do 
      user = User.create({username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation], email: params[:email]})
      redirect to "/users/#{user.id}"
    end

    get "/users" do 
      @users = User.all
      erb :users
    end

    get "/users/:id" do 
      @user = User.find(session[:user_id])
      if @user.nil?
        redirect to "/users"
      elsif is_authenticated_user
        erb :profile
      else
        @user = User.find(params[:id])
        erb :user
      end
    end

    get "/users/:id/edit" do 
      redirect to "/users" if !is_authenticated_user
      @user = User.find(params[:id])
      erb :edit_profile
    end

    patch "/users/:id" do 
      @user = User.find(params[:id])
      edit_user(@user)
      redirect to build_path(["users", @user.id])
    end

    get "/articles" do
      @user = User.current_user(session)
      @articles = Article.all
      erb :articles
    end

    get "/articles/new" do
      redirect to "/articles" if !session[:user_id]
      @categories = Category.all
      erb :new_article
    end

    post "/articles" do 
      user = User.current_user(session)
      article = Article.create_from_params(params)
      revision = Revision.create(content: params[:content], created_at: DateTime.now, user_id: user.id, article_id: article.id)
      # params[:categories].each {|category_id| article.add_category(category_id) }
      redirect to "/articles/#{article.id}"
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

    get "/categories" do 
      @categories = Category.all
      erb :categories
    end

    get "/categories/:id" do 
      @category = Category.find(params[:id])
      erb :category
    end

  end # Server
end # App