class Channel < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  has_many :videos, dependent: :nullify

  # before_validation(if: -> { uid.present? && changes[:uid].present? }) do
  #   update_videos
  # end

  # Fills all channel video details from API
  def update_videos
    channel = Yt::Channel.new id: uid
    channel.videos.each do |yt_video|
      video = videos.find { |v| v.uid == yt_video.id }
      video ||= videos.build(uid: yt_video.id)
      video.fill_details(yt_video)
    end

    save
  end

  private

    # In their current form, the below methods are _only_ for scraping
    # new channels, not updating old ones.
    # YouTube API quota cost: 3 + 100 for each page scraped / 10,000/day
    # def scrape
    #   yt_channel = Yt::Channel.new id: uid
    #   unless page_token.nil?
    #     yt_channel.instance_variable_set(:@page_token, page_token)
    #   end
    #   scrape_page(yt_channel)
    #   self.page_token = yt_channel.instance_variable_get(:@page_token)
    #   save
    # end

    def scrape
      yt_channel = Yt::Channel.new id: uid
      videos = yt_channel.videos
                         .where(published_before: videos.last&.published_at)
                         .first(50)
      scrape_page(videos)
      save

      scrape if videos.count == 50
    end

    def scrape_page(videos)
      videos.each do |yt_video|
        video = videos.find { |v| v.uid == yt_video.id }
        video ||= videos.build(uid: yt_video.id)
        video.fill_details(yt_video)
      end
    end
end
