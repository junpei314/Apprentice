class ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @article = Article.find_by(slug: params[:slug])
    render json: {article: @article}
  end

  def create
    slug = article_params[:title].gsub(/\s/, '-').downcase
    @article = Article.new(article_params)
    @article.update(slug: slug)
    @article.save
    render json: {article: @article}
  end

  def update
    @article = Article.find_by(slug: params[:slug])
    @article.update(article_params)

    if article_params[:title].present?
      slug = article_params[:title].gsub(/\s/, '-').downcase
      @article.update(slug: slug)
    end

    @article.save
    render json: {article: @article}
  end

  def destroy
    @article = Article.find_by(slug: params[:slug])
    @article.destroy
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body)
  end
end
