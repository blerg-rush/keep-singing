require 'rails_helper'

RSpec.describe Video, type: :model do
  before(:each) do
    @video1 = create(:video)
  end

  it 'is valid with valid attributes' do
    expect(@video1).to be_valid
  end

  it 'is not valid without a uid' do
    @video1.uid = nil
    expect(@video1).to_not be_valid
  end

  it 'has a unique uid' do
    video2 = build(:video)
    expect(video2).to_not be_valid
  end

  describe '#fill_details' do
    it 'adds missing video details from API' do
      VCR.use_cassette('single_video') do
        video2 = Video.new uid: 'OQSNhk5ICTI'
        yt_video = Yt::Video.new id: video2.uid
        video2.fill_details(yt_video)
        expect(video2.title).to eq 'Yosemitebear Mountain Double Rainbow 1-8-10'
      end
    end

    it "doesn't overwrite existing details" do
      VCR.use_cassette('single_video') do
        yt_video = Yt::Video.new id: 'OQSNhk5ICTI'
        @video1.fill_details(yt_video)
        expect(@video1.title).to_not eq 'Yosemitebear Mountain Double Rainbow 1-8-10'
      end
    end
  end
end
