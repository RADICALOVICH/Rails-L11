require 'rails_helper'

RSpec.describe "Sequences", type: :request do
  describe "GET /input" do
    it "returns http success" do
      get "/sequence/input"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /result" do
    it "returns http success" do
      get "/sequence/result"
      expect(response).to have_http_status(:success)
    end
  end

end
