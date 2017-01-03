class Api::V1::SearchesController < ApplicationController
  def search
    @search_params = params[:search]
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
    @search_response = JSON.parse(response.body)
    if @search_response['success']
      # a PORO to process the response data so the controller stays thinner
      imgur_data = @search_response['data']
      slimmer = []
      imgur_data.each do |result|
        if result['is_album'] == true
          # you could fetch the direct link to pictures with another api call, and have the album be the image_context,
          # but let's not risk hitting our rate limit since it's a free service
        else
          link = result['link']
          image_alt_text = result['title'].length < 19 ? result['title'] : result['title'][0..19] + '...'
          image_context = 'http://imgur.com/' + result['id']
          slimmer.push({"link" => link, "image_alt_text" => image_alt_text, "image_context" => image_context})  
        end
      end
      #render :json => @search_response
      render :json => slimmer.empty? ? [{}] : slimmer
    else
      @error_code = response.code
      render :error
    end
  end
end