class Api::V1::BaseController < ApplicationController

  protect_from_forgery

  include Exceptions::Controller
  include Authentication::Controller

end
