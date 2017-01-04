class CustomResponse
  # a PORO to hold the weeding out logic from the imgur response
  attr_reader :custom_image_info, :image_count
  def initialize(imgur_response, search_params)
    custom_data = []
    image_count = 0
    imgur_response.each do |result|
      if result['is_album'] == true
        # you could fetch the direct link to pictures with another api call, and have the album be the image_context,
        # but let's not risk hitting our rate limit since it's a free service
      else
        link = result['link']
        image_alt_text = result['title'].length < 19 ? result['title'] : result['title'][0..19] + '...'
        image_context = 'http://imgur.com/' + result['id']
        custom_data.push({"link" => link, "image_alt_text" => image_alt_text, "image_context" => image_context})  
        image_count += 1
      end
    end
    @custom_image_info = custom_data
    @image_count = image_count
    @s = Search.create(search_string: search_params)
    if !@s.valid?
      puts 'error in registering search_string'
    end
  end

end