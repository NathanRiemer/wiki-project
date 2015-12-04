module App
  class Server < Sinatra::Base
    set :method_override, true
    enable :sessions
    helpers Sinatra::LinkUtils
    $markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions={})

    # def markdown_renderer
    #   @markdown_renderer || @markdown_renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
    # end

    get "/" do
      @user = current_user
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
      @user = current_user
      @users = User.all
      erb :users
    end

    get "/users/:id" do 
      @user = current_user
      if @user.nil?
        redirect to "/users"
      elsif is_authenticated_user
        erb :profile
      else
        @this_user = User.find(params[:id])
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
      if params[:is_admin] == "true"
        @user.update(is_admin: true)
      else
        edit_user(@user)
      end
      redirect to build_path(["users", @user.id])
    end

    get "/articles" do
      @user = current_user
      @articles = Article.all
      erb :articles
    end

    get "/articles/new" do
      redirect to "/articles" if !session[:user_id]
      @user = current_user
      @categories = Category.all
      erb :new_article
    end

    post "/articles" do 
      user = current_user
      article = Article.create_from_params(params)
      revision = Revision.create(content: params[:content], created_at: DateTime.now, user_id: user.id, article_id: article.id)
      # params[:categories].each {|category_id| article.add_category(category_id) }
      redirect to "/articles/#{article.id}"
    end

    get "/articles/:id" do 
      @user = current_user
      @article = Article.find(params[:id])
      erb :article
    end

    get "/articles/:id/edit" do 
      redirect to "/articles" if !session[:user_id]
      @user = current_user
      @article = Article.find(params[:id])
      erb :edit_article
    end

    post "/articles/:id/revisions" do 
      redirect to "/articles" if !session[:user_id]
      user = current_user
      article = Article.find(params[:id])
      revision = Revision.create(content: params[:content], created_at: DateTime.now, user_id: user.id, article_id: article.id)
      redirect to build_path(["articles", article.id])
    end

    get "/articles/:id/revisions" do 
      @user = current_user
      @article = Article.find(params[:id])
      erb :revisions
    end

    get "/articles/:id/revisions/:rev_id" do 
      @user = current_user
      @revision = Revision.find(params[:rev_id])
      erb :revision
    end

    post "/articles/:id/revisions/:rev_id/comments" do 
      redirect to build_path(["articles", params[:id], "revisions", params[:rev_id]]) if !session[:user_id]
      revision = Revision.find(params[:rev_id])
      Comment.create(content: params[:content], created_at: DateTime.now, user_id: session[:user_id], revision_id: params[:rev_id])
      redirect to build_path(["articles", params[:id], "revisions", params[:rev_id]])
    end

    post "/articles/:id/categories" do 
      article = Article.find(params[:id])
      title = params[:category]
      category = Category.find_by(title: title)
      category = Category.create(title: title) if !category
      article.categories.push(category) unless article.categories.include?(category)
      redirect to build_path(["articles", params[:id]])
    end

    get "/articles/:id/categories/edit" do 
      @user = current_user
      @article = Article.find(params[:id])
      erb :edit_article_categories
    end

    delete "/articles/:id/categories/:cat_id" do 
      article = Article.find(params[:id])
      category = Category.find(params[:cat_id])
      article.categories.delete(category)
      redirect to build_path(["articles", article.id])
    end

    get "/categories" do 
      @user = current_user
      @categories = Category.all.order(:title)
      erb :categories
    end

    get "/categories/new" do            
      redirect to "/categories" if !session[:user_id]
      @user = current_user
      erb :new_category
    end

    post "/categories" do 
      category = Category.create(title: params[:title])
      redirect to build_path(["categories", category.id])
    end

    get "/categories/:id" do 
      @user = current_user
      @category = Category.find(params[:id])
      erb :category
    end

  end # Server
end # App