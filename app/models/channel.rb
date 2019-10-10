class Channel < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  has_many :videos, dependent: :nullify

  # Sends scrape task to background task
  def save_and_scrape!
    return false unless valid?

    uid_changed = changes[:uid].present?
    if save && uid_changed
      NewChannelScraper.perform_async(id)
    else
      UpdateChannelScraper.perform_async(id)
    end
  end

  # Queries the YT API for the current channel's videos, repeating
  # until the last page has been scraped (videos.count < 50)
  # YouTube API quota cost: 103 for each 50 videos scraped
  def scrape
    yt_channel = Yt::Channel.new id: uid
    yt_videos = yt_channel.videos
                          .where(published_before: when_last_published)
                          .first(50)
    scrape_page(yt_videos)
    scrape if yt_videos.count == 50
  end

  # Scrapes all videos added to a channel since the last scrape
  # Not meant to add entire channels; will fail entirely if
  # it attempts to scrape more videos than quota allows
  # YouTube API quota cost: 3 + 100 for each 50 videos scraped
  def update
    yt_channel = Yt::Channel.new id: uid
    yt_videos = yt_channel.videos
                          .where(published_after: when_last_scraped)
    scrape_page(yt_videos)
  end

  private

    # Builds a new video from each result in a page of yt_videos
    def scrape_page(yt_videos)
      yt_videos.each do |yt_video|
        video = videos.find { |v| v.uid == yt_video.id }
        video ||= videos.build(uid: yt_video.id)
        video.fill_details(yt_video)
      end
      self.last_scraped = Time.zone.now
      save
    end

    # Returns datetime when the last scraped video was published, or
    # the current datetime if none exist, in YouTube-accepted format
    def when_last_published
      time = videos.any? ? videos.last.published_at : Time.zone.now
      time.strftime '%FT%T.999Z'
    end

    # Returns datetime when the channel was last scraped
    def when_last_scraped
      last_scraped.strftime '%FT%T.999Z'
    end
end
