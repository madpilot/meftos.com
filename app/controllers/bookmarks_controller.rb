class BookmarksController < ApplicationController
  include AuthenticatedSystem
  before_filter :login_required, :except => [ 'index' ]
  
  def index
    respond_to do |format|
      format.atom do
        if since = request.if_modified_since
          @bookmarks = Bookmark.find :all, :conditions => [ 'created_at > ?', since ], :order => 'created_at DESC'
          render :nothing => true, :status => 304 if @bookmarks.empty?
          return true
        else
          @bookmarks = Bookmark.find :all, :order => 'created_at DESC'
        end
      end
      format.rss do
        if since = request.if_modified_since
          @bookmarks = Bookmark.find :all, :conditions => [ 'created_at > ?', since ], :order => 'created_at DESC'
          render :nothing => true, :status => 304 if @bookmarks.empty?
          return true
        else
          @bookmarks = Bookmark.find :all, :order => 'created_at DESC'
        end
      end
      format.json do
        count = params[:count] || 50
        @bookmarks = Bookmark.find :all, :limit => count, :order => 'created_at DESC'
        render :json => @bookmarks.to_json
      end
      format.js do
        count = params[:count] || 50
        @bookmarks = Bookmark.find :all, :limit => count, :order => 'created_at DESC'
        render :text => "if(typeof(MEftos) == 'undefined') MEftos = {}; MEftos.bookmarks = " + @bookmarks.to_json + ";"
      end

      format.html do
        if params[:tag]
          # Eww. This is gross
          @bookmarks = Bookmark.paginate :page => params[:page], :conditions => 'id IN (' + Bookmark.find_tagged_with(params[:tag], :order => 'created_at DESC').map(&:id).join(',') + ')'
          @tag = params[:tag]
        else
          @bookmarks = Bookmark.paginate :page => params[:page], :order => 'created_at DESC'
        end

        @page_title = "Bookmarks"
      end
    end
  end

  def new
    @page_title = "Create a boomark"
  end

  def metadata
    params[:bookmark] =  { :url => params[:url] } if params[:url]
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
