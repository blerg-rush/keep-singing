# TODO: Add client notificaiton or logging of success
class NewChannelScraper
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(id)
    @channel = Channel.find(id)
    @channel.scrape
  end
end
