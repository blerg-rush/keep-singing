class HomeController < ApplicationController
  def index
    channel = Yt::Channel::new id: 'UCwXOPyNfdUIhsM4NykfhPFw'
    @results = channel.videos.first
  end
end
