class Video < ApplicationRecord
  validates :uid, presence: true
  belongs_to :channel

  private

    before_validation(if: -> { uid.present? && changes['uid'].present? }) do
      add_details
    end

    def add_details
      video = Yt::Video.new id: uid
      self.link = "https://www.youtube.com/watch?v=#{uid}"
      self.title = trim(video.title)
      self.description = video.description
      self.channel_id = video.channel_id
    rescue Yt::Errors::NoItems
      self.title = ''
    end
end
