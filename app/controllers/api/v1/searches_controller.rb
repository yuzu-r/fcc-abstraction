class Api::V1::SearchesController < ApplicationController
  def search
    @params = params[:search]
    @page = params[:page]
    logger.info 'hi ' + @params
    logger.info 'pages: ' + @page
  end
end