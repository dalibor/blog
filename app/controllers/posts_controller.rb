class PostsController < ApplicationController

  def index
    @posts          = scope.order('published_at DESC').includes('tags').
                            where('published_at IS NOT NULL')
    @posts_by_month = Post.posts_by_month

    respond_to do |format|
      format.html
      format.rss { render :layout => false}
    end
  end

  def show
    @post           = Post.where('published_at IS NOT NULL').find(params[:id])
    @posts_by_month = Post.posts_by_month
  end

  private
    def scope
      if params[:tag].present? && (tag = Tag.find_by_name(params[:tag]))
        tag.posts
      elsif params[:year].present? && params[:month].present?
        Post.where("YEAR(published_at) = ? AND MONTH(published_at) = ?",
                   params[:year], params[:month])
      else
        Post
      end
    end
end
