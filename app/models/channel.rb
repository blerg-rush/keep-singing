class Channel < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  has_many :videos, dependent: :nullify

  before_validation(if: -> { uid.present? && changes[:uid].present? }) do
    update_videos
  end

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
end
