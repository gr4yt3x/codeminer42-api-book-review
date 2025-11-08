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

  describe "GET /users/:id/" do
    context "when user exists" do
      it "returns the user" do
        get "/users/#{bob.id}"
        expect(last_response.status).to eq(200)
        expect(json_body['name']).to eq('Bob')
      end
    end
  end

    context "when user does not exist" do
      it "returns 404" do
        get '/users/99999'
        expect(last_response.status).to eq(404)
        expect(json_body['error']).to eq('User not found')
      end
    end

  describe "GET /users/:id/reviews" do
    context "when user exists" do
      it "returns all reviews for the user" do
        create(:review, user: bob, comment: "Great!")
        create(:review, user: bob, comment: "Excellent!")

        get "/users/#{bob.id}/reviews"

        expect(last_response.status).to eq(200)
        expect(json_body.size).to eq(2)
        expect(json_body.first['comment']).to eq('Great!')
        expect(json_body.last['comment']).to eq('Excellent!')
      end
    end
  end
end
