require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should allow_value(nil).for(:password) }

  it { should have_many(:comments) }
  it { should have_many(:goals) }

  describe "#ensure_session_token" do
    it "ensures session token is not nil" do
      user = FactoryBot.build(:user)
      expect(user.session_token).to_not be_nil
    end
  end

  describe "#reset_session_token" do
    it "resets user's session token" do
      user = FactoryBot.build(:user)
      old_session_token = user.session_token
      expect(user.reset_session_token!).to_not eq(old_session_token)
    end
  end

  describe "::find_by_credentials" do
    it "self.find_by_credentials" do
      user = FactoryBot.create(:user)
      expect(User.find_by_credentials(user.username, user.password)).to eq(user)
    end
  end





end
