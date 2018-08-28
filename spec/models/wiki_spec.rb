require 'rails_helper'

RSpec.describe Wiki, type: :model do

  let(:user) { User.create!(email: "user@blocipedia.com", password: "password") }
  let(:wiki) { Wiki.create!(title: "New Wiki Title", body: "New Wiki Body", user: user) }

  it { is_expected.to belong_to(:user) }

  describe "attributes" do
    it "has title, body and user attributes" do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body, user: user)
    end
  end

end
