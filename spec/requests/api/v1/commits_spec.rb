describe "Commits API" do
  let(:user) { create :user }

  describe "#index" do
    it 'list of commits' do
      create_list(:commit, 5, user: user)
      get "/api/commits", {}, set_auth_token(user)

      expect(json['commits'].length).to eq(5)
      expect(json['private_attr']).to eq(nil)
    end
  end

  describe "#show" do
    it 'one commit' do
      commit = create(:commit, user: user)
      get "/api/commits/#{commit.id}", {}, set_auth_token(user)
      expect(json['commit'].length).to_not eq(nil)
    end
  end

  describe "#destroy" do
    let(:commit) { create(:commit, user: user) }

    context 'when object is not owned' do
      let(:fake_user) { create :user }
      it 'responds with 404' do
        delete "/api/commits/#{commit.id}", {}, set_auth_token(fake_user)
        expect(json['error']).to eq(nil)
      end
    end
  end
end