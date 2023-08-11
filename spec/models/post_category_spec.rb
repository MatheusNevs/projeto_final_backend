require 'rails_helper'

RSpec.describe PostCategory, type: :model do
  context 'validates' do
    it "it should be valid" do
      expect(build(:post_category)).to be_valid
    end

    it "create a post category without a post_id shouldn't be valid" do
      expect(build(:post_category, post: nil)).to be_invalid
    end

    it "create a post_category without a category_id shouldn't be valid" do
      expect(build(:post_category, category: nil)).to be_invalid
    end

  end
end
