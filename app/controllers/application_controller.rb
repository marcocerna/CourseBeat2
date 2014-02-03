class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :authorize

  def authorize
    # Refactor: Replace the redirect with something else (something like having sign-in modal pop up)

    # redirect_to new_session_path unless current_user
  end

  # These methods allow us to use an array for cookies[:ratings]
  def read_cookies
    JSON.parse(cookies[:ratings]) rescue []
  end

  # Needs this to work in the views
  helper_method :read_cookies

  def write_cookies(new_cookies)
    cookies[:ratings] = new_cookies.to_json
  end
  helper_method :write_cookies

end