class Api::V1::SearchesController < ApplicationController
  def search
    @search_params = params[:search]
    @page = params[:offset] || 1.to_s
    #logger.info 'search for: ' + @search_params
    #logger.info 'requested page: ' + @page
    headers = {
      "Authorization" => "Client-ID " + ENV["imgur_client_id"]
    }
    base_url = 'https://api.imgur.com'
    #path = '/3/gallery/random/random'
    path = '/3/gallery/search?q=' + @search_params+'&sort=time&page='+ @page
    #logger.info 'path: '+ path
    uri = URI.parse(base_url+path)
    request, data = Net::HTTP::Get.new(path, headers)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.request(request)
    #logger.info 'response message' + response.message # OK
    #logger.info 'response code ' + response.code # 200
    # empty: {"data":[],"success":true,"status":200}
    @search_response = response.body
    if @search_response["success"]
      render :json => @search_response
    else
      @error_code = response.code
      render :error
    end
  end
end