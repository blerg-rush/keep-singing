class HomeController < ApplicationController
  def index
    @videos = Video.order('created_at DESC').take(10)
  end
end
