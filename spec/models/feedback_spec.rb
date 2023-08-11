require 'rails_helper'

RSpec.describe Feedback, type: :model do
  context 'validates' do
    it 'it should be valid' do
      expect(build(:feedback)).to be_valid
    end
    
    it 'create a feedback with false like should be valid' do
      expect(build(:feedback, like: false)).to be_valid
    end
    
    it 'create a feedback with a false comment should be valid' do
      expect(build(:feedback, comment:nil)).to be_valid
    end
    
    it 'create a feedback without a user_id should be invalid' do
      expect(build(:feedback, user:nil)).to be_invalid
    end
    
    it 'create a feedback without a post_id should be invalid' do
      expect(build(:feedback, post:nil)).to be_invalid
    end
  end
end
