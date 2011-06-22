require 'rubygems'
require 'sinatra'
require 'erb'

def view_exists?(view)
  File.exists?(Dir.pwd + "/views/#{view}.erb")
end

get '/*' do
  @domain = request.env["HTTP_HOST"].sub(/^(?:www)\./, '')
  
  view = @domain
  view = 'default' unless view_exists?(@domain)
  erb view.to_sym
end
