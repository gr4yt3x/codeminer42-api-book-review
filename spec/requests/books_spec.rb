describe "@Books - API endpoints", type: :request do
  let!(:book1) { create(:book, title: "A Song of Ice and Fire")} # sem o published_year para ser utilizado nos testes
  let!(:book2) { create(:book, title: "The lion, the witch and the wardrobe", published_year: 1950)}
  let!(:book3) { create(:book, title: "The Wealth of Nations" , published_year: 1776)}
  
  describe "GET /books" do
    it "returns all books" do
      get '/books'
      expect(last_response.status).to eq(200)
      expect(json_body.size).to eq(3)
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

  describe "GET /books?published_year=" do
    it 'returns books by published_year' do
      get "/books?published_year=#{book2.published_year}"

      expect(last_response.status).to eq(200)
      expect(json_body.size).to eq(1)
    end
  end

  describe "POST /books/" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          title: "Crime and Punishment",
          author: "Fiódor Dostoiévski",
          published_year: "1866"
        }
      end

      it "creates a new book and returns it" do
        expect {
          post "/books/", valid_params
        }.to change(Book, :count).by(1)

        expect(last_response.status).to eq(201)
        expect(json_body['title']).to eq("Crime and Punishment")
        expect(json_body['author']).to eq("Fiódor Dostoiévski")
        expect(json_body['published_year']).to eq(1866)
      end
   end

   context "with invalid parameters" do
     let(:invalid_params) {{ title: "" }}
     it "returns 422 with an error message" do
        post '/books/', invalid_params

        expect(last_response.status).to eq(422)
        expect(json_body['error']).to be_present
     end
   end
  end

  describe "GET /books/:id/reviews" do
    context "when book exists" do
      let(:bob)   { create(:user, name: "Bob") }
      let(:alice) { create(:user, name: "Alice") }

      it "returns all reviews for the book" do
        create(:review, book: book1, user: bob, comment: "Great!")
        create(:review, book: book1, user: alice, comment: "Good book!")

        get "/books/#{book1.id}/reviews"

        expect(last_response.status).to eq(200)
        expect(json_body.size).to eq(2)
        expect(json_body.first['comment']).to eq('Great!')
        expect(json_body.first['user_id']).to eq(bob.id)
        expect(json_body.last['comment']).to eq('Good book!')
        expect(json_body.last['user_id']).to eq(alice.id)
      end
    end

    context "when book does not exist" do
      it "returns a 404 not found" do
        get "/books/999999/reviews"

        expect(last_response.status).to eq(404)
      end
    end
  end

  describe "PUT /books/:id" do
    context "with valid_params" do
      let(:valid_params) {{ title: "New Title", author: "New Author" }}

      it 'updates the book and returns 200' do
        put "/books/#{book1.id}", valid_params

        expect(last_response.status).to eq(200)
        expect(json_body['title']).to eq("New Title")
        expect(json_body['author']).to eq("New Author")
      end
    end
    
    context "with invalid parameters" do
      let(:invalid_params) { { title: "", author: "" } }

      it "returns 422 with an error message" do
        put "/books/#{book1.id}", invalid_params

        expect(last_response.status).to eq(422)
        expect(json_body['error']).to be_present
      end
    end

    context "when book does not exist" do
      it "returns 404" do
        put "/books/9999", { title: "Doesn't exist" }

        expect(last_response.status).to eq(404)
      end
    end
  end

  describe "DELETE /books/:id" do
    context "when book exists" do
      it "deletes the book and returns 204" do
        delete "/books/#{book1.id}"

        expect(last_response.status).to eq(204)
        expect(Book.find_by(id: book1.id)).to be_nil
      end
    end

    context "when book does not exist" do
      it "returns 404" do
        delete "/books/9999"

        expect(last_response.status).to eq(404)
      end
    end
  end
end
