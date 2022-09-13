class ArticlesController < ApplicationController
  include Paginable

  # GET /articles or /articles.json
  def index
    paginated = paginate(Article.recent)
    render_collection(paginated)
  end

  def show
      article = Article.find(params[:id])
      render json: serializer.new(article)
  end

  def serializer
    ArticleSerializer
  end
end
