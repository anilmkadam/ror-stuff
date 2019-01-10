class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    # if article_params[:title].empty? && article_params[:description].empty?
    #   render 'new'
    if @article.save
      flash[:notice] = "Article Successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

end
