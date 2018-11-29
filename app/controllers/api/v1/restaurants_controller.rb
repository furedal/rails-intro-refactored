class Api::V1::RestaurantsController < Api::V1::BaseController
  def index
    render json: Restaurant.all, include: params[:include] || []
  end
end
