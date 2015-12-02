module Sinatra

  module LinkUtils

    def build_link (pathArray, text)
      path = pathArray.join("/")
      "<a href='/#{path}'>#{text}</a>"
    end

  end

end