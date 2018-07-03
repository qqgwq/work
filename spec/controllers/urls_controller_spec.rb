require '/Users/gaoboyue/work/spec/rails_helper'

RSpec.describe UrlsController, type: :controller do
  describe "#New" do
    subject(:url) { Url.new }
    it "test new action" do
      get :new
      expect(url).to be_a_new(Url)
    end
  end
end