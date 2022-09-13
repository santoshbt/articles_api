class ArticlesController < ApplicationController
  include Paginable

  # GET /articles or /articles.json
  def index
    paginated = paginate(Article.recent)
    render_collection(paginated)
  end

  def show
  end

  def serializer
    ArticleSerializer
  end
end
