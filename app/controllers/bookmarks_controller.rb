class BookmarksController < ApplicationController
  include AuthenticatedSystem
  before_filter :login_required, :except => [ 'index' ]
  
  def index
    if params[:tag]
      # Eww. This is gross
      @bookmarks = Bookmark.paginate :page => params[:page], :conditions => 'id IN (' + Bookmark.find_tagged_with(params[:tag], :order => 'created_at DESC').map(&:id).join(',') + ')'
      @tag = params[:tag]
    else
      @bookmarks = Bookmark.paginate :page => params[:page], :order => 'created_at DESC'
    end

    @page_title = "Bookmarks"
  end

  def new
    @page_title = "Create a boomark"
  end

  def metadata
    @bookmark = Bookmark.new(params[:bookmark])
    @bookmark.fetch_metadata

    @page_title = "Create a bookmark"
  end

  def create
    @bookmark = Bookmark.new(params[:bookmark])
    begin
      @bookmark.save!
      flash[:notice] = "The bookmark has been saved!"
      redirect_to :action => 'index'
    rescue
      @page_title = "Create a bookmark"
      render :template => 'bookmarks/metadata'
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
    @page_title = "Update a bookmark"
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark.attributes = params[:bookmark]
    begin
      @bookmark.save!
      flash[:notice] = "The bookmark has been updated!"
      redirect_to :action => 'index'
    rescue
      @page_title = "Update a bookmark"
      render :template => 'bookmarks/edit'
    end
  end

  def delete
    @bookmark = Bookmark.find(params[:id])
    @page_title = "Delete a bookmark"
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.delete
    redirect_to :action => 'index'
  end
end
