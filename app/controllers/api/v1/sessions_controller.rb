module Api::V1
  class SessionsController < Api::BaseController
    before_action :authenticate_user!

    def identity
      p current_user
      render_json_message(200, resource: { user: ::IdentitySerializer.new(current_user) })
    end
  end
end
