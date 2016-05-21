class FeedController < ApplicationController
  def index
    if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
end
