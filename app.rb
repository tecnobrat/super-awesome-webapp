require 'sinatra/base'

require 'tilt/redcarpet'
require 'tilt/haml'

if ENV["RACK_ENV"] == "production"
  require "rack-json-logs"
else
  require 'byebug'
end


module SuperAwesomeWebapp
  class App < Sinatra::Base
    configure :production do
      set :raise_errors, true
      set :logging, false
      set :dump_errors, false
      use Rack::JsonLogs
    end

    def whoami
      `hostname`
    end

    get "/" do
      @version = ENV.fetch("VERSION")

      markdown :home, layout_engine: :haml
    end

    get "/health" do
      status 200
    end

    get "/where" do
      "#{whoami} - serving request for #{request.path}"
    end
  end
end
