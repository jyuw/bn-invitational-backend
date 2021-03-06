
RSpec.describe Api::V1::AthletesController, type: :request do
  describe 'GET /api/v1/athletes' do
    let!(:athlete) { create(:athlete, starttime: "1200") }
    let!(:athlete_two) { create(:athlete, name: 'Lara', starttime: "1220") }
    let!(:athlete_three) { create(:athlete, name: 'Kalle', starttime: "1210") }
    let(:object) { JSON.parse(response.body) }
    before do
  end

    it 'Should return a list of all athletes' do
      get '/api/v1/athletes'
      expected_response = eval(file_fixture('athlete_list.txt').read)
      expect(object).to eq expected_response
    end

    it 'Should return a specific athlete' do
      get "/api/v1/athletes/#{athlete.id}"
      expected_response = eval(file_fixture('athlete.txt').read)
      expect(object).to eq expected_response
    end
    it 'should return athletes image' do
      athlete.image.attach(io: File.open(fixture_path + '/dummy_image.jpg'), filename: 'attachment.jpg', content_type: 'image/jpg')
        get "/api/v1/athletes/#{athlete.id}"
       expect(object['data']).to have_attribute(:image)
     end
  end
end
