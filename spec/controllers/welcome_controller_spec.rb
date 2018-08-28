require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe "GET #index" do
    # it "returns http success" do
    #   get :index
    #   expect(response).to have_http_status(:success)
    # end

    it "renders #index template" do
     get :index
     expect(response).to render_template("index")
   end
  end

  describe "GET #about" do
  #   it "returns http success" do
  #     get :about
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  it "renders #about template" do
      get :about
      expect(response).to redirect_to( new_user_session_path )
    end
  end

end
