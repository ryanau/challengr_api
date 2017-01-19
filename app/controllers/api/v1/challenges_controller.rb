require 'securerandom'

module Api::V1
  class ChallengesController < Api::BaseController
    before_action :authenticate_user!

    def create
      challenge = current_user.challenges.create!(post_params)
      uid = SecureRandom.urlsafe_base64(6)
      challenge.update(uid: uid) 
      render_json_message(201, message: 'Challenge created', resource: { uid: uid })
    end

    private

    def post_params
      params.require(:challenge).permit(:name, :location, :frequency, :time)
    end
  end
end
