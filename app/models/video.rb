class Video < ApplicationRecord
  validates :link, presence: true
  before_save :get_details

  private

    def add_details
      video = Yt::Video.new url: link
      self.uid = video.id
      self.title = video.title
    rescue Yt::Errors::NoItems
      resource.title = ''
    end
end
