RSpec.describe "Users", type: :request do
 describe 'POST /users #create' do
   it '無効な値だと登録されないこと' do
     expect {
       post users_path, params: { user: { name: '',
                                          email: 'user@invlid',
                                          password: 'foo',
                                          password_confirmation: 'bar' } }
     }.to_not change(User, :count)
   end
   context '有効な値の場合' do
    let(:user_params) { { user: { name: 'Example User',
                                  email: 'user@example.com',
                                  password: 'password',
                                  password_confirmation: 'password' } } }
    it '登録されること' do
      expect {
        post users_path, params: user_params
      }.to change(User, :count).by 1
    end

    it 'users/showにリダイレクトされること' do
      post users_path, params: user_params
      user = User.last
      expect(response).to redirect_to user
    end
    end
  end
end