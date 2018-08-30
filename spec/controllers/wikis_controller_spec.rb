require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:my_user) {  User.create!(email: "user@blocipedia.com", password: "password") }
  let(:my_wiki) { Wiki.create!(title: "New Wiki Title", body: "New Wiki Body", user: user) }

  before do
    sign_in(:my_user)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, id: my_wiki.id
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, id: my_wiki.id
      expect(response).to render_template :new
    end

    it "instantiates @wiki" do
      get :new, id: my_wiki.id
      expect(assigns(:my_wiki).not_to be_nil)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, id: my_wiki.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, id: my_wiki.id
      expect(response).to render_template :edit
    end

    it "assigns wiki to be updated to @wiki" do
      get :edit, id: my_wiki.id

      wiki_instance = assigns(:wiki)

      expect(wiki_instance.id).to eq my_wiki.id
      expect(wiki_instance.title).to eq my_wiki.title
      expect(wiki_instance.body).to eq my_wiki.body
    end
  end

  describe "PUT #update" do
    it "updates wiki with expeted attributes" do
      new_title = "Very new Wiki title"
      new_body = "Very new Wiki body"

      put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
      expect(response).to redirect_to[my_wiki]
    end
  end

  describe "DELETE #destroy" do

    it "returns http redirect" do
      delete :destroy, id: my_wiki.id
      expect(response).to redirect_to[my_wiki]
    end

   # it "deletes the wiki" do
   #   delete :destroy, id: my_wiki.id
   #   count = Wiki.where({id: my_wiki.id}).size
   #   expect(count).to eq 0
   # end
   #
   # it "redirects to wiki index" do
   #   delete :destroy, id: my_wiki.id
   #   expect(response).to redirect_to[my_wiki]
   # end
 end

end
