describe "Projects API" do
  let(:user) { create :user }

  it 'not #authorised without token' do
    get '/api/projects'

    expect(response).to_not be_success
  end

  it '#authorised with token' do
    get '/api/projects', {}, set_auth_token(user)

    expect(response).to be_success
  end
end