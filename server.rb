module App
  class Server < Sinatra::Base
    set :method_override, true
    enable :sessions
    helpers Sinatra::LinkUtils
    $markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(with_toc_data: true), autolink: true)
    $toc_markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML_TOC, extensions={})

    # def markdown_renderer
    #   @markdown_renderer || @markdown_renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
    # end

    get "/" do
      @user = current_user
      @intro = Article.find_by(title: "Welcome")
      @popular_categories = Category.popular
      erb :index
    end

    get "/search" do 
      @user = current_user
      if params[:q]
        @searching = true
        query = params[:q]
        if params[:in] == "articles"
          @results = Article.where_title_include?(query)
          @message = "Articles with titles containing '#{query}'"
        elsif params[:in] == "categories"
          @results = Category.where_title_include?(query)
        elsif params[:in] == "content"
          @results = Article.where_content_include?(query)
          @message = "Articles with content containing '#{query}'"
        end
      end
      erb :search
    end

    get "/login" do 
      @message = "Login failed. Incorrect username and/or password." if params[:msg] == "failure"
      erb :'users/login'
    end

    post "/sessions" do 
      user = User.find_by({username: params[:username]}).try(:authenticate, params[:password])
      if user
        session[:user_id] = user.id
        redirect to "/"
      else
        redirect to "/login?msg=failure" 
      end
    end

    delete "/sessions" do
      session[:user_id] = nil
      redirect to "/"
    end      

    get "/signup" do 
      erb :'users/new'
    end

    post "/users" do 
      user = User.create({username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation], email: params[:email]})
      session[:user_id] = user.id
      redirect to "/users/#{user.id}"
    end

    get "/users" do 
      @user = current_user
      @users = User.all.order(:username)
      erb :'users/index'
    end

    get "/users/:id" do 
      @user = current_user
      @this_user = User.find(params[:id])
      if @user.nil? || @this_user.nil?
        redirect to "/users"
      else
        erb :'users/show'
      end
    end

    get "/users/:id/edit" do 
      redirect to "/users" if !is_authenticated_user
      @user = User.find(params[:id])
      erb :'users/edit_profile'
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

    get "/users/:id/articles" do 
      @user = current_user
      @this_user = User.find(params[:id])
      @articles = @this_user.articles.uniq
      erb :'articles/index'
    end

    get "/articles" do
      @user = current_user
      @articles = Article.all.order(:title)
      erb :'articles/index'
    end

    get "/articles/new" do
      redirect to "/articles" if !session[:user_id]
      @user = current_user
      @categories = Category.all
      erb :'articles/new'
    end

    post "/articles" do 
      user = current_user
      @article = Article.create_from_params(params)
      revision = Revision.create(content: params[:content], created_at: DateTime.now, user_id: user.id, article_id: @article.id, primary_image_url: params[:primary_image_url])
      add_categories_to_article if params[:categories]
      redirect to "/articles/#{@article.id}"
    end

    get "/articles/:id" do 
      @user = current_user
      @article = Article.find(params[:id])
      if params[:print] == "true"
        erb :'articles/show', layout: :print_layout
      else
        erb :'articles/show'
      end
    end

    get "/articles/:id/edit" do 
      redirect to "/articles" if !session[:user_id]
      @user = current_user
      @article = Article.find(params[:id])
      erb :'articles/edit'
    end

    patch "/articles/:id" do 
      redirect to "/articles" if !session[:user_id]
      user = current_user
      article = Article.find(params[:id])
      article.update(title: params[:title])
      redirect to build_path(["articles", article.id])
    end

    delete "/articles/:id" do 
      redirect to "/articles" if !session[:user_id]
      article = Article.find(params[:id])
      article.destroy
      redirect to "/articles"
    end

    post "/articles/:id/revisions" do 
      redirect to "/articles" if !session[:user_id]
      user = current_user
      article = Article.find(params[:id])
      if params[:revision_id]
        revision = Revision.find(params[:revision_id]).dup
        revision.created_at = DateTime.now
        revision.save
      else
        revision = Revision.create(content: params[:content], created_at: DateTime.now, user_id: user.id, article_id: article.id, primary_image_url: params[:primary_image_url])
      end 
      redirect to build_path(["articles", article.id])
    end

    get "/articles/:id/revisions" do 
      @user = current_user
      @article = Article.find(params[:id])
      erb :'revisions/index'
    end

    get "/articles/:id/revisions/:rev_id" do 
      @user = current_user
      @article = Article.find(params[:id])
      @revision = Revision.find(params[:rev_id])
      erb :'revisions/show'
    end

    post "/articles/:id/revisions/:rev_id/comments" do 
      redirect to build_path(["articles", params[:id], "revisions", params[:rev_id]]) if !session[:user_id]
      revision = Revision.find(params[:rev_id])
      Comment.create(content: params[:content], created_at: DateTime.now, user_id: session[:user_id], revision_id: params[:rev_id])
      redirect to build_path(["articles", params[:id], "revisions", params[:rev_id]])
    end

    delete "/articles/:id/revisions/:rev_id/comments/:comment_id" do 
      comment = Comment.find(params[:comment_id])
      comment.delete
      redirect to build_path(["articles", params[:id], "revisions", params[:rev_id]])
    end

    post "/articles/:id/categories" do 
      @article = Article.find(params[:id])
      add_categories_to_article
      redirect to build_path(["articles", params[:id]])
    end

    get "/articles/:id/categories/edit" do 
      @user = current_user
      @article = Article.find(params[:id])
      erb :'articles/edit_article_categories'
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
      erb :'categories/index'
    end

    get "/categories/new" do            
      redirect to "/categories" if !session[:user_id]
      @user = current_user
      erb :'categories/new'
    end

    post "/categories" do 
      category = Category.create(title: params[:title])
      redirect to build_path(["categories", category.id])
    end

    get "/categories/:id" do 
      @user = current_user
      @category = Category.find(params[:id])
      erb :'categories/show'
    end

    get "/categories/:id/edit" do 
      redirect to build_path(["categories", params[:id]]) if !session[:user_id]
      @user = current_user
      @category = Category.find(params[:id])
      erb :'categories/edit'
    end

    patch "/categories/:id" do 
      category = Category.find(params[:id])
      category.update(title: params[:title])
      redirect to build_path(["categories", params[:id]])
    end

    delete "/categories/:id" do 
      category = Category.find(params[:id])
      category.delete
      redirect to "/categories"
    end

    delete "/categories/:id/articles/:art_id" do 
      article = Article.find(params[:art_id])
      category = Category.find(params[:id])
      category.articles.delete(article)
      redirect to build_path(["categories", category.id])
    end

  end # Server
end # App