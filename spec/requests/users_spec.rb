describe "@User - API endpoints", type: :request do
  let!(:bob)   { create(:user, name: "Bob") }
  let!(:alice) { create(:user, name: "Alice") }
  let!(:carol) { create(:user, name: "Carol") }

  describe "GET /users" do
    it "returns all users ordered by name" do
      get '/users'
      expect(last_response.status).to eq(200)
      names = json_body.map { |u| u['name'] }
      expect(names).to eq(['Alice', 'Bob', 'Carol'])
    end
  end

  describe "GET /users/:id" do
    context "when user exists" do
      it "returns the user with reviews" do
        create(:review, user: alice, body: "Great!")
        get "/users/#{alice.id}"
        expect(last_response.status).to eq(200)
        expect(json_body['name']).to eq('Alice')
        expect(json_body['reviews'].size).to eq(1)
        expect(json_body['reviews'].first['body']).to eq('Great!')
      end
    end

    context "when user does not exist" do
      it "returns 404" do
        get '/users/99999'
        expect(last_response.status).to eq(404)
        expect(json_body['error']).to eq('User not found')
      end
    end
  end
end
