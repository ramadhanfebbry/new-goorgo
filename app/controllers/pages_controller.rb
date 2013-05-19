class PagesController < ApplicationController
  def about_us
  end

  def privacy
  end

  def term_of_use
  end

  def custom
  	@page = Page.find(params[:title])
  end
end
