class SlimResponse
  # a PORO to hold the weeding out logic from the imgur response
  def initialize(imgur_response)
    # need link, truncated title for alt_text, page (?)
    imgur_data = imgur_response.data
    slimmer = imgur_data.map{|result| result.slice(:title, :link)}
    puts slimmer[0]
  end
end