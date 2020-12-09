require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # validations of the columns

  # describe User do
    # columns: session_token, password_digest, username
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_uniqueness_of(:session_token) }
  # end

  # class scope methods; find_by_credentials

  describe "find_by_credentials" do

    let!(:user) { create(:user) }

      context "finds the correct user" do
        # result has to be :user
        # user.username
        it "should find the same user" do
        expect(user.find_by_credentials('#{user.username}', 'onering')).to eq(user)
        end
      end

      context "finds the wrong user" do
        # result is not :user
        it "should not find the user" do
        expect(user.find_by_credentials('#{user.username}', 'onering')).not_to eq(user)
        end
      end

      # context where username is correct but password is wrong
      context "finds user but wrong password" do
        it "should not return user as password given was wrong" do
          expect(user.find_by_credentials('#{user.username}', 'tworing')).not_to eq(user)
        end
      end
      
    end
  


end
