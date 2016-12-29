class ApplicationController < ActionController::API
  def render_json_message(status, options = {})
    render json: {
      message: options[:message],
      resource: options[:resource],
      to: options[:to],
      errors: options[:errors]
    }, status: status
  end

  def set_token(token)
    response.set_header('token', token)
  end
end
