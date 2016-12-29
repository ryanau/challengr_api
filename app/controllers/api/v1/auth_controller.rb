module Api::V1
  class AuthController < Api::BaseController
    before_action :test
    before_action :authenticate_user!
    def facebook
      user_info, access_token = Omniauth::Facebook.authenticate(params[:code])
      @user = User.from_omniauth(user_info, access_token)

      if @user.persisted?
        sign_in(@user)
        token = JWTWrapper.encode({ uid: @user.uid })
        set_token(token)
        render_json_message(200, message: 'Successfully signed in.', resource: { token: token })
      else
        render_json_message(400, errors: ['Signed in failed.'])
      end
    end

    def test
      puts request
      p 'yay'
    end
  end
end
