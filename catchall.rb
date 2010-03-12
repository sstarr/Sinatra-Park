require 'rubygems'
require 'sinatra'
require 'haml'

Domains = %w{linkdeleted.com allmouthandnotrousers.com evans.cx pimpdog.co.uk straydogimages.com straydogimages.co.uk}
DefaultDomain = 'default'

# what domain does the host contain?
# put this here because helpers are a pain to test!
def view_for_domain(host)
  return DefaultDomain if host.nil?
  
  Domains.find do |domain|
     host.include?(domain)
  end || DefaultDomain
end

def view_exists?(view)
  File.exists?(Dir.pwd + "/views/#{view}.haml")
end

# the catch-all route
get '/*' do
  # parse domain
  @view = view_for_domain(request.env["HTTP_HOST"])
  
  # override with text anywhere in url (for testing)
  splat = params['splat'].first 
  if(@view == DefaultDomain && !splat.empty?) then 
    @view = view_for_domain(splat)
  end
  
  @domain = request.env["HTTP_HOST"].sub(/^(?:www)\./, '')
  
  # ensure view exists, and load
  @view = DefaultDomain unless view_exists?(@view)
  haml @view.to_sym
end
