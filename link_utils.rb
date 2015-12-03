module Sinatra

  module LinkUtils

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

  end

end