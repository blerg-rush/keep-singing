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
end
