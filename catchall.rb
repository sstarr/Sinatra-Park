require 'rubygems'
require 'sinatra'
require 'erb'

Domains = %w{emmawhiting.co.uk}

def view_exists?(view)
  File.exists?(Dir.pwd + "/views/#{view}.erb")
end

# the catch-all route
get '/*' do
  # parse domain
  @domain = request.env["HTTP_HOST"].sub(/^(?:www)\./, '')
  
  # ensure view exists, and load
  @view = @domain
  @view = 'default' unless view_exists?(@domain)
  erb @view.to_sym
end
