class PagesController < ApplicationController
  include AuthenticatedSystem

  def bookmarklets
    @page_title = "Bookmarklets"
  end
end
