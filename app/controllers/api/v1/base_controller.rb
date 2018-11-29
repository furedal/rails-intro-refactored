class Api::V1::BaseController < ApplicationController

  protect_from_forgery

  include Exceptions::Controller

  before_action :authenticate

  def authenticate
    raise Exceptions::Unauthorized.new "Missing access token" if token.blank?
    @@current_user = User.find_by_token(token)
    raise Exceptions::Unauthorized.new "Invalid access token" if @@current_user.blank?
  end

  def token
    request.headers['X-INTRO-ACCESS-TOKEN']
  end
end
