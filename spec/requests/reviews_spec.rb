describe "@Reviews - API endpoints", type: :request do
  let!(:user) { User.create!(name: "Alice") }
  let!(:book) { Book.create!(title: "Moby Dick", author: "Herman Melville") }
  let!(:review1) { Review.create!(user: user, book: book, rating: 5, comment: "Great!") }
  let!(:review2) { Review.create!(user: user, book: book, rating: 4, comment: "Very Good!") }

  describe "GET /" do
    it "returns all reviews" do
      get '/reviews'

      expect(last_response.status).to eq(200)
      expect(json_body.size).to eq(2)
      expect(json_body.map { |r| r['comment'] }).to include("Great!", "Very Good!")
    end
  end
end

