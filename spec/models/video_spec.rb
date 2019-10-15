require 'rails_helper'

RSpec.describe Video, type: :model do
  before(:all) do
    @video1 = create(:video)
  end

  it 'is valid with valid attributes' do
    expect(@video1).to be_valid
  end
end
