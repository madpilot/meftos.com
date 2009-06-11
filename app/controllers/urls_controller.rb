class UrlsController < ApplicationController
  include AuthenticatedSystem
  layout proc { |c| c.params[:popup] == '1' ? 'popup' : 'application' } 
  
  def index
    redirect_to :action => 'new'
  end

  def show
    url = Url.find(params[:permalink].to_i(36))
    redirect_to url.url, :status => :moved_permanently
  end

  def new
    @page_title = "Shorten a URL"
  end

  def create
    params[:shorten] =  { :url => params[:url] } if params[:url]
    params[:shorten][:url] = Url.normalize(params[:shorten][:url])
    @shorten = Url.find_by_url(params[:shorten][:url]) || Url.new(params[:shorten])
    
    begin
      @shorten.save!
      @page_title = "URL shortened!"
    rescue ActiveRecord::RecordInvalid
      @page_title = "Shorten a URL"
      render :template => 'urls/new'
    end
  end
end
