class SearchController < ApplicationController
  include AuthenticatedSystem
  
  def index
    @page = params[:page] || 1
    @query = params[:q]
    @results = []
    @results = Bookmark.paginate_search @query, :page => @page if @query
  end
end
