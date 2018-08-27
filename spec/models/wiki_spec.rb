require 'rails_helper'

RSpec.describe Wiki, type: :model do

  let(:user) { create(:user) }
  let(:my_wiki) { create(:wiki, user: user) }

  it { is_expected.to belong_to(:user) }

  describe "attributes" do
    it "has title, body and private attributes" do
      expect(my_wiki).to have_attributes(title: my_wiki.title, body: my_wiki.body, private: my_wiki.private?)
    end
  end

end
