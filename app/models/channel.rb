class Channel < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  has_many :videos, dependent: :nullify

  def update_videos
    channel = Yt::Channel.new id: uid
    channel.videos.each do |yt_video|
      video = videos.find_or_initialize_by(uid: yt_video.id)
      video.fill_details(yt_video)
      video.save(validate: false)
    end
  end
end
