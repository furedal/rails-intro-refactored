module Authentication
  module Controller
    extend ActiveSupport::Concern
    included do
      before_action :authenticate
    end

    def authenticate
      raise Exceptions::Unauthorized.new "Missing access token" if token.blank?
      @@current_user = User.find_by_token(token)
      raise Exceptions::Unauthorized.new "Invalid access token" if @@current_user.blank?
    end

    def token
      request.headers['X-INTRO-ACCESS-TOKEN']
    end
  end
end
