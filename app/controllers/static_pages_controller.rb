class StaticPagesController < ApplicationController
  def welcome
    @request = request.base_url
  end
end
