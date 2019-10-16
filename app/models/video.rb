class Video < ApplicationRecord
  searchkick word_middle: %i[title description]
  validates :uid, presence: true, uniqueness: true
  belongs_to :channel, optional: true

  def search_data
    {
      title: title,
      description: description
    }
  end

  # Scrapes a single video immediately
  def save_and_scrape!
    return false unless valid?

    query_details
    save
  end

  # Passes new video details from API collection object
  def fill_details(yt_video)
    self.title ||= trim(yt_video.title)
    self.link ||= "https://www.youtube.com/watch?v=#{yt_video.id}"
    self.description ||= yt_video.description
    self.channel_uid ||= yt_video.channel_id
    self.published_at ||= yt_video.published_at
  end

  # Grabs new video details from Yt API
  def query_details
    yt_video = Yt::Video.new id: uid
    fill_details(yt_video)
  rescue Yt::Errors::NoItems
    self.title = ''
  end

  # Removes unnecessary substrings from video title
  def trim(title)
    # existing
    title.to_s.gsub(/[\(\[]?karaoke version[\)\}]?/i, '')
         .gsub(/[\(\[]?karaoke[\)\}]?/i, '')
         .gsub('&#39;', "'")
         .squish
  end
end
