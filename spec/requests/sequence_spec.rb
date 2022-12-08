require 'rails_helper'

RSpec.describe "Sequences", type: :request do
  describe 'GET /' do
    before { get root_path } # перед каждым тестом делать запрос

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders input template' do
      expect(response).to render_template(:input)
    end

    it 'responds with html' do
      expect(response.content_type).to match(%r{text/html})
    end
  end

  describe 'POST /result' do
    context 'when params are valid' do
      let(:number_params) { 3 }
      let(:string_array_params) { '16 25 39' }
      before { post result_path, params: { number: number_params, string_array: string_array_params }, xhr: true }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'renders show templates' do
        expect(response).to render_template(:result)
      end

      it 'responds with turbo stream' do
        expect(response.content_type).to match(%r{text/vnd.turbo-stream.html})
      end

      it 'assigns valid model object' do
        expect(assigns(:res).valid?).to be true
      end
    end

    context 'when params are invalid' do
      before { post result_path, xhr: true }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'renders result templates' do
        expect(response).to render_template(:result)
      end

      it 'responds with turbo stream' do
        expect(response.content_type).to match(%r{text/vnd.turbo-stream.html})
      end

      it 'assigns valid model object' do
        expect(assigns(:res).valid?).to be false
      end
    end
  end

  describe 'GET /show_xml' do
    before { get show_xml_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'responds with xml' do
      expect(response.content_type).to match(%r{xml})
    end
  end
end
