class UpdateChannelScraper
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(id)
    @channel = Channel.find(id)
    @channel.update
  end
end
