module Sinatra

  module LinkUtils

    def current_user 
      User.find(session[:user_id]) if session[:user_id]
    end

    def current_admin?
      current_user.admin? if current_user
    end

    def build_path(pathArray)
      "/" + pathArray.join("/")
    end

    def build_link (pathArray, text)
      path = build_path(pathArray)
      "<a href='#{path}'>#{text}</a>"
    end

    def build_option (value, text)
      "<option value='#{value}'>#{text}</option>"
    end

    def is_authenticated_user
      session[:user_id] == params[:id].to_i
    end

    def new_input (attribute)
      "<label>#{attribute.capitalize}: <input type='text' name='#{attribute}'></label><br>"
    end

    def edit_input (instance, attribute)
      "<label>#{attribute.capitalize}: <input type='text' name='#{attribute}' value='#{instance[attribute]}'></label><br>"
    end

    def change_if_modified (instance, attribute)
      if params[attribute] != instance[attribute]
        instance[attribute] = params[attribute]
      end
    end

    def edit_user (user_instance)
      attributes = ["avatar_image_url", "email", "first_name", "last_name", "city", "state", "country"]
      attributes.each { |attribute| change_if_modified(user_instance, attribute)}
      user_instance.save
    end

    def add_categories_to_article
      titles = params[:categories].split(",")
      titles.each do |title|
        title.strip!
        category = Category.find_by(title: title)
        category = Category.create(title: title) if !category
        @article.categories.push(category) unless @article.categories.include?(category)
      end
    end

    def diff_revisions(rev1, rev2)
      diff = Diffy::Diff.new(rev1.content, rev2.content, :include_plus_and_minus_in_html => true).to_s(:html)
      if diff == '<div class="diff"></div>'
        '<div class="diff"><ul><li class="unchanged"><span>Content is unchanged</span></li></ul></div>'
      else
        diff
      end
    end

  end

end