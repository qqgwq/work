require '/Users/gaoboyue/work/spec/rails_helper'

RSpec.describe UrlsController, type: :controller do
  describe "#New" do
    subject(:url) { Url.new }
    it "test new action" do
      get :new
      expect(url).to be_a_new(Url)
    end
  end

  it "has a 200 status" do
    get :new
    expect(response.status).to eq(200)
  end

  it "renders new template submit success" do
    get :new
    expect(response).to render_template :new
  end
end