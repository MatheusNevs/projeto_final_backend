require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
arequire 'rails_helper'

RSpec.describe User, type: :model do
  context "testing validates" do
    it "when params are ok should be valid" do
      expect(build(:user)).to be_valid
    end
    
    it "when params aren't ok shouldn't be valid" do
      expect(build(:user, name: nil)).to be_invalid
    end

    it "when creating new user with email already signed in shouldn't be valid" do
      user1 = create(:user, email: 'teste1@gmail.com')
      expect(build(:user, email: 'teste1@gmail.com')).to be_invalid
    end

    it "when paramter is_admin isn't either true or false" do
      expect(build(:user, is_admin: nil)).to be_invalid
    end

    it "trying to create a user with a password lenght smaller than 6 characters should be invalid" do 
      expect(build(:user, password: '12345')).to be_invalid
    end
  end
end
