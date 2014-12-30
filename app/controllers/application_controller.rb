class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_account

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

private

  def record_not_found
    render plain: "404 Not Found", status: 404
  end

  def set_account
    @account = Account.find_by_subdomain!(request.subdomain)
 end
end
