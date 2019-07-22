require 'rails_helper'

RSpec.describe "FirstVisits", type: :request do
  describe "GET /" do
    it "It renders the static page" do
      get staticpages_home_path
      expect(response).to render_template(:landing_page)
      expect(response).to have_http_status(200)
    end
  end
end
