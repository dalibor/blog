class PostsController < ApplicationController

  before_filter :load_archive, only: [:index, :show]

  def index
    @posts = Post.all.reverse

    if params[:tag].present?
      @posts = @posts.select { |post| post.tags.include?(params[:tag]) }
    end

    if params[:year].present?
      @posts = @posts.select { |post| post.date.year == params[:year].to_i }
    end

    respond_to do |format|
      format.html
      format.rss { render :layout => false}
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def load_archive
    @posts_by_year = Post.by_year
  end
end
