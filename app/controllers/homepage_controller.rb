class HomepageController < ApplicationController
  prepend_before_filter :check_for_authorization

  def index
    @user_info = current_user
    @top_keywords = top_keywords
  end
end
