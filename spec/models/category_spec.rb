require 'rails_helper'

RSpec.describe Category, type: :model do
  context "validates - " do
    it "it should be valid" do 
      expect(build(:category)).to be_valid
    end

    it "nil title should'nt be valid" do
      expect(build(:category, title:nil)).to be_invalid
    end

    it "nill description shouldn't be valid" do
      expect(build(:category, description:nil)).to be_invalid
    end

    it "category title already created should be invalid" do
      create(:category, title:'Fofoca')
      expect(build(:category, title: 'Fofoca')).to be_invalid
    end
  end
end
