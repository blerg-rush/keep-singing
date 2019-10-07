class Video < ApplicationRecord
  validates :link, presence: true
  before_save :add_details

  private

    def add_details
      video = Yt::Video.new uid: uid
      self.link = "https://www.youtube.com/watch?v=#{uid}"
      self.title = video.title.trim
      self.description = video.description
      self.channel_id = video.channel_id
    rescue Yt::Errors::NoItems
      self.title = ''
    end

    def trim(string)
      string.strip_karaoke_version
            .strip_karaoke
            .squish
    end

    def strip_karaoke_version(string)
      string.gsub(/(K|k)araoke (V|v)ersion/, '')
    end

    def strip_karaoke(string)
      string.gsub(/(K|k)araoke/, '')
    end
end
