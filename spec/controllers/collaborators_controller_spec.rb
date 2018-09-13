require 'rails_helper'
include SessionsHelper

RSpec.describe CollaboratorsController, type: :controller do
  let(:my_user) {User.create!(email: "user@blocipedia.com", password: "password") }
  let(:my_wiki) {Wiki.create!(Wiki.create!(title: "New Wiki Title", body: "New Wiki Body", user: user) }

  before do
    sign_in(:my_user)
  end

end
