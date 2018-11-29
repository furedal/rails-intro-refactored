class Api::V1::ArticlesController < Api::V1::BaseController
    def index
        render json: Article.all, include: params[:include] || []
    end
end