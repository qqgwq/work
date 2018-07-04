class UrlsController < ApplicationController
  before_action :find_url, only: [:show, :shortened]

  def new
    @url = Url.new
  end

  def show
    redirect_to @url.sanitized_url
    @url.views
  end


  def create
    @url = Url.new(url_params)
    @url.sanitize
    if @url.new_url?
      if @url.save
        redirect_to shortened_path(@url.short_url)
      else
        render 'new'
      end
    else
      flash[:notice] = "A short link for this URL is already in our database"
      redirect_to shortened_path(@url.find_duplicate.short_url)
    end
  end

  private

  def find_url
    @url = Url.find_by_short_url(params[:short_url])
  end

  def url_params
    params.require(:url).permit(:original_url)
  end
end
