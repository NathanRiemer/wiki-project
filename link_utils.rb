module Sinatra

  module LinkUtils

    def build_link (pathArray, text)
      path = pathArray.join("/")
      "<a href='/#{path}'>#{text}</a>"
    end

    def build_option (value, text)
      "<option value='#{value}'>#{text}</option>"
    end

  end

end