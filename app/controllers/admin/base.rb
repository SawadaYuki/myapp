class Admin::Base < ApplicationController
  before_filter :admin_login_required

  private
  def admin_login_required
  	p "admin_login_required #{@current_user.username}---------------------------------------"
    raise Forbidden unless @current_user.try(:administrator?)
  end
end
