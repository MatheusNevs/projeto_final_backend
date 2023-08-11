require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validates' do
    it 'it should be valid' do
      expect(build(:post)).to be_valid
    end

    it 'it should not be valid' do
      expect(build(:post, title:nil)).to be_invalid
    end

    it 'it should not be valid' do
      expect(build(:post, description:nil)).to be_invalid
    end

    it 'it should not be valid' do
      expect(build(:post, user:nil)).to be_invalid
    end

  end
end
