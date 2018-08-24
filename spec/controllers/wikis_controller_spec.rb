require 'rails_helper'


RSpec.describe WikisController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_wiki) { create(:wiki) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end

    # it "renders the #edit view" do
    #    get :edit, {id: my_wiki.id}
    #    expect(response).to render_template :edit
    #  end
    #
    # it "assigns post to be updated to @wiki" do
    #    get :edit, {id: my_wiki.id}
    #
    #    wiki_instance = assigns(:wiki)
    #
    #    expect(wiki_instance.id).to eq my_wiki.id
    #    expect(wiki_instance.title).to eq my_wiki.title
    #    expect(wiki_instance.body).to eq my_wiki.body
    # end

  end

end
