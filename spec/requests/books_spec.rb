describe "@Books - API endpoints", type: :request do
  let!(:book1) { create(:book, title: "A Song of Ice and Fire")}
  let!(:book2) { create(:book, title: "The lion, the witch and the wardrobe")}

  describe "GET /books" do
    it "returns all books" do
      get '/books'
      expect(last_response.status).to eq(200)
      expect(json_body.size).to eq(2)
      expect(json_body.map  { |b| b['title'] }).to include("A Song of Ice and Fire")
    end
  end

  describe "GET /books/id" do
    context "when book exists" do
      it "correctly returns the book" do
        get "/books/#{book1.id}"
        expect(last_response.status).to eq(200)
        expect(json_body['title']).to eq("A Song of Ice and Fire")
        expect(json_body).to have_key('author')
        expect(json_body).to have_key('published_year')
      end
    end

    context "when book does not exist" do
      it "returns 404 with error message" do
        get "/books/9999"
        expect(last_response.status).to eq(404)
        expect(json_body['error']).to eq('Book not found')
      end
    end
  end
end
