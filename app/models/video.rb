class Video < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  belongs_to :channel

  # Passes new video details from API collection object
  def fill_details(yt_video)
    self.title ||= trim(yt_video.title)
    self.link ||= "https://www.youtube.com/watch?v=#{yt_video.id}"
    self.description ||= yt_video.description
    self.channel_uid ||= yt_video.channel_id
  end

  private

    before_validation(if: -> { uid.present? && changes['uid'].present? }) do
      query_details
    end

    # Grabs new video details from Yt API
    def query_details
      yt_video = Yt::Video.new id: uid
      fill_details(yt_video)
    rescue Yt::Errors::NoItems
      self.title = ''
    end
end
