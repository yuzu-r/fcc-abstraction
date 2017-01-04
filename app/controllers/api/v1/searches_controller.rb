class Api::V1::SearchesController < ApplicationController
  def search
    @search_params = params[:query]
    @page = params[:offset] || 1.to_s

    headers = {
      "Authorization" => "Client-ID " + ENV["imgur_client_id"]
    }
    base_url = 'https://api.imgur.com'
    path = '/3/gallery/search?q=' + @search_params+'&sort=time&page='+ @page

    uri = URI.parse(base_url+path)
    request, data = Net::HTTP::Get.new(path, headers)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.request(request)
    search_response = JSON.parse(response.body)

    if search_response['success']
      imgur_data = search_response['data']
      custom_response = CustomResponse.new(imgur_data, @search_params)
      render :json => custom_response.image_count == 0 ? [{}] : custom_response.custom_image_info
    else
      @error_code = response.code
      render :error
    end
  end

  def recent
    @search_strings = Search.order(created_at: :desc, search_string: :asc).limit(5)
  end

end