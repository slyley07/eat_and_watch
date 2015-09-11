require 'net/http'
require 'json'
require_relative './poster'
require_relative './title'
require_relative './release'


module TMDB
  class Client
    def initialize
      @url  = 'http://api.themoviedb.org/3/'
    end

    def make_endpoint(page)
      @uri = URI(@url)
    end
  end
end
