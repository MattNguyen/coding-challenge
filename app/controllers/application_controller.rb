class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def check_for_authorization
    redirect_to :login unless facebook_token
  end

  def facebook_token
    session[:facebook_token]
  end

  def current_user
    session[:user_info]
  end

  def facebook_user_id
    session[:facebook_user_id]
  end

  def status_messages
    graph = Koala::Facebook::API.new(facebook_token)
    graph.fql_query("select message from status where uid='#{ facebook_user_id }'")
  end

  def top_keywords
    arr = status_messages.map do |msg|
            msg['message'].downcase.gsub(/ /,'_').gsub(/\W/,'').split('_')
          end.flatten

    freq = {}

    arr.each do |element|
      next if freq.has_key?(element)
      freq[element] = arr.count(element)
    end

    freq.sort_by{|x,y|y}[-20..-1]
  end
end
