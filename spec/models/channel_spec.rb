require 'rails_helper'

RSpec.describe Channel, type: :model do
  before(:each) do
    @channel1 = create(:channel)
  end

  it 'is valid with valid attributes' do
    expect(@channel1).to be_valid
  end

  it 'is not valid without a uid' do
    @channel1.uid = nil
    expect(@channel1).to_not be_valid
  end

  it 'has a unique uid' do
    channel2 = build(:channel)
    expect(channel2).to_not be_valid
  end

  it 'is not valid with if marked non-embeddable' do
    @channel1.uid = NON_EMBEDDABLE_CHANNELS[0]
    expect(@channel1).to_not be_valid
  end
end
