class Api::V1::SearchesController < ApplicationController
  def search
    @search_params = params[:search]
    @page = params[:offset]
    logger.info 'search for: ' + @search_params
    logger.info 'requested page: ' + @page
    headers = {
      "Authorization" => "Client-ID " + ENV["imgur_client_id"]
    }
    base_url = 'https://api.imgur.com'
    #path = '/3/gallery/random/random'
    path = '/3/gallery/search?q=' + @search_params+'&sort=time&page='+ @page
    logger.info 'path: '+ path
    uri = URI.parse(base_url+path)
    request, data = Net::HTTP::Get.new(path, headers)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.request(request)
    logger.info 'response ' 
    @search_response = response.body
    render :json => @search_response
  end
end