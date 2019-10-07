class Video < ApplicationRecord
  validates :link, presence: true
  before_save :get_details

  private

    def add_details
      video = Yt::Video.new url: link
      self.uid = video.id
      self.title = video.title.trim
    rescue Yt::Errors::NoItems
      resource.title = ''
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
